local _, FlexCommand = ...

FC_RegisterEvent("ERROR", function(text, ...)
    FC_PrintError(text, ...)
    error(string.format(text, ...))
end)

FC_RegisterEvent("COMMAND_EXECUTE", function(command, args, spec, ...)
    if not args["if"] then
        return true
    end

    local result = { value = false }
    local chunk = loadstring("local result = ...; result.value = (" .. args["if"] .. ")")

    if not chunk then
        FC_PrintWarning("Invalid condition expression '%s'.", args["if"])
        return false
    end

    chunk(result)

    return result.value
end)

FC_RegisterEvent("PROFILE_LOAD", function(profile)
    return FlexCommand.profile.CheckFilters(profile["filters"])
end)
