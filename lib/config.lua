local _, FlexCommand = ...

FlexCommand.config = {}

if not FlexCommandConfig then
    FlexCommandConfig = {}
end

FlexCommand.config.GetConfig = function(key, default)
    if not FlexCommandConfig[key] then
        return default
    end

    return FlexCommandConfig[key]
end

FlexCommand.config.SetConfig = function(key, value)
    FlexCommandConfig[key] = value
end
