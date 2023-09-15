FC_RegisterCommand("help", "Show registered commands", function()
    print(string.format("FlexCommand version: %s", GetAddOnMetadata("FlexCommand", "Version")))

    for command, spec in pairs(FC_GetAllRegisteredCommands()) do
        print(string.format("|cffffff00%s|r: %s", command, spec["help"]))
    end
end)
