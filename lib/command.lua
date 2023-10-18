local _, FlexCommand = ...

FlexCommand.command = {}

-- Registered commands
local registeredCommands = {}

-- Command triggers
local commandTriggers = {}

-- Trigger listener
local triggerListener

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

    if not args["if"] then
        return spec["handler"](args, event, ...)
    end

    local result = { value = false }
    local chunk = loadstring("local result = ...; result.value = (" .. args["if"] .. ")")

    if not chunk then
        error(string.format("Invalid condition expression '%s'.", args["if"]))
    end

    chunk(result)

    if result.value then
        return spec["handler"](args, event, ...)
    end
end

FlexCommand.command.ExecuteString = function(str)
    local command, args = FlexCommand.command.ParseCommand(str)

    if not args["on"] then
        return FlexCommand.command.ExecuteCommand(command, args, nil)
    end

    return FlexCommand.command.RegisterCommandTrigger(args["on"], command, args)
end

FlexCommand.command.RegisterCommandTrigger = function(event, command, args)
    if not commandTriggers[event] then
        commandTriggers[event] = {}
        triggerListener:RegisterEvent(event)
    end

    table.insert(commandTriggers[event], { command, args })
end

FlexCommand.command.InitTriggerListener = function()
    -- Frame to register events for commands
    triggerListener = CreateFrame("Frame")

    triggerListener:SetScript("OnEvent", function(_, event, ...)
        if commandTriggers[event] then
            for i = 1, #commandTriggers[event] do
                local command, args = unpack(commandTriggers[event][i])
                if FlexCommand.command.ExecuteCommand(command, args, event, ...) == false then
                    return false
                end
            end
        end
    end)
end
