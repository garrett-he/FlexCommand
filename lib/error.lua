local _, FlexCommand = ...

FlexCommand.error = {}

local lastError

FlexCommand.error.GetLastError = function()
    return lastError
end

FlexCommand.error.SetLastError = function(msg, ...)
    lastError = string.format(msg, ...)
end
