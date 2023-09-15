local _, FlexCommand = ...

FlexCommand.command = {}

-- Registered commands
local registeredCommands = {}

FlexCommand.command.ParseCommand = function(str)
    local command, substr = string.match(str, "^%s*([^ ]+)%s*(.*)")
    local args = {}

    if not substr then
        return command, args
    end

    for key, value in string.gmatch(substr, "([%w-]+)='([^']+)'") do
        args[key] = value
    end

    for key, value in string.gmatch(substr, '([%w-]+)="([^"]+)"') do
        args[key] = value
    end

    for key, value in string.gmatch(substr, "([%w-]+)=([^'\" ]+)") do
        if value == "true" then
            args[key] = true
        elseif value == "false" then
            args[key] = false
        elseif value == "nil" then
            args[key] = nil
        elseif string.match(value, "^%d+$") or (string.find(value, "%.") and string.match(value, "^%d+%.%d+$")) then
            args[key] = tonumber(value)
        else
            args[key] = value
        end
    end

    return command, args
end

FlexCommand.command.GetAllRegisteredCommands = function()
    return registeredCommands
end

FlexCommand.command.RegisterCommand = function(command, help, handler)
    if registeredCommands[command] then
        error(string.format("Command '%s' already registered.", command))
    end

    registeredCommands[command] = {
        help = help,
        handler = handler
    }
end

FlexCommand.command.UnregisterCommand = function(command)
    if not registeredCommands[command] then
        error(string.format("Command '%s' not registered yet.", command))
    end

    registeredCommands[command] = nil
end

FlexCommand.command.ExecuteCommand = function(command, args, ...)
    local spec = registeredCommands[command]

    if not spec then
        error(string.format("Command '%s' not registered yet.", command))
    end

    return spec["handler"](args, ...)
end
