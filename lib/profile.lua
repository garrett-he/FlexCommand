local _, FlexCommand = ...

FlexCommand.profile = {}

-- Registered profiles
local registeredProfiles = {}

-- Profile filters
local profileFilters = {}

FlexCommand.profile.RegisterProfile = function(name, profile)
    if registeredProfiles[name] then
        FlexCommand.event.RaiseEvent("FC_ERROR", "Profile '%s' already exists.", name)
    end

    profile["__loaded"] = false
    registeredProfiles[name] = profile
end

FlexCommand.profile.UnregisterProfile = function(name)
    if not registeredProfiles[name] then
        FlexCommand.event.RaiseEvent("FC_ERROR", "Profile '%s' not registered yet.", name)
    end

    registeredProfiles[name] = nil
end

FlexCommand.profile.GetAllRegisteredProfiles = function()
    return registeredProfiles
end

FlexCommand.profile.LoadProfile = function(name, force)
    local profile = registeredProfiles[name]

    if not profile then
        FlexCommand.event.RaiseEvent("FC_ERROR", "Profile '%s' not registered yet.", name)
    end

    if profile["__loaded"] then
        return
    end

    if not (force or FlexCommand.event.RaiseEvent("FC_PROFILE_LOAD", profile)) then
        return
    end

    if profile["preload"] then
        for _, preload in pairs(profile["preload"]) do
            FlexCommand.profile.LoadProfile(preload, force)
        end
    end

    if profile["commands"] then
        for _, str in ipairs(profile["commands"]) do
            FlexCommand.command.ExecuteString(str)
        end
    end

    profile["__loaded"] = true

    FlexCommand.logging.PrintInfo("Profile '%s' loaded.", name)
end

FlexCommand.profile.RegisterFilter = function(name, handler)
    if profileFilters[name] then
        FlexCommand.event.RaiseEvent("FC_ERROR", "Profile filter '%s' already registered.", name)
    end

    profileFilters[name] = handler
end

FlexCommand.profile.CheckFilters = function(filters)
    if not filters then
        return true
    end

    local result = true

    for name, args in pairs(filters) do
        if not profileFilters[name] then
            FlexCommand.event.RaiseEvent("FC_ERROR", "Profile filter '%s' not registered yet.", name)
        end

        result = result and profileFilters[name](args)
    end

    return result and true
end
