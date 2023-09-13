local _, FlexCommand = ...

FlexCommand.command = {}

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
