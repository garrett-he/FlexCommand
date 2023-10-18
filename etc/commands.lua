FC_RegisterCommand("help", "Show registered commands", function()
    print(string.format("FlexCommand version: %s", GetAddOnMetadata("FlexCommand", "Version")))

    for command, spec in pairs(FC_GetAllRegisteredCommands()) do
        print(string.format("|cffffff00%s|r: %s", command, spec["help"]))
    end
end)

FC_RegisterCommand("profile-list", "List all registered profiles", function()
    for name, profile in pairs(FC_GetAllRegisteredProfiles()) do
        print(string.format("%s: %s", name, profile.__loaded and "|cff00ff00Enabled|r" or "|cffff0000Disabled|r"))
    end
end)

FC_RegisterCommand("profile-load", "Load the specified profile", function(args)
    FC_LoadProfile(args["name"])
end)

FC_RegisterCommand("config-get", "Get configuration value by key", function(args)
    local key = args["key"]
    local value = FC_GetConfig(key)

    if value == nil then
        FC_PrintError("Configuration with key '%s' not assigned yet.", key)
        return
    end

    FC_PrintInfo("Configuration: %s = %s", key, value)
end)

FC_RegisterCommand("config-set", "Set configuration value by key", function(args)
    FC_SetConfig(args["key"], args["value"])
end)
