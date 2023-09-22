local _, FlexCommand = ...

FlexCommand.profile = {}

-- Registered profiles
local registeredProfiles = {}

FlexCommand.profile.RegisterProfile = function(name, profile)
    if registeredProfiles[name] then
        error(string.format("Profile '%s' already exists.", name))
    end

    registeredProfiles[name] = profile
end

FlexCommand.profile.UnregisterProfile = function(name)
    if not registeredProfiles[name] then
        error(string.format("Profile '%s' not registered yet.", name))
    end

    registeredProfiles[name] = nil
end

FlexCommand.profile.GetAllRegisteredProfiles = function()
    return registeredProfiles
end
