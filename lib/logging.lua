local _, FlexCommand = ...

FlexCommand.logging = {}

-- Default logger
local defaultLogger

local Logger = { level = 3 }
Logger.__index = Logger

local LOG_COLORS = {
    { name = "ERROR", color = "ffff0000" },
    { name = "WARNING", color = "ffff9900" },
    { name = "INFO", color = "ffffffff" },
    { name = "DEBUG", color = "ff00ffff" },
}

function Logger:PrintMessage(level, text, ...)
    if level > self.level then
        return
    end

    print(string.format("|c%s[FlexCommand][%s]: %s|r", LOG_COLORS[level]["color"], LOG_COLORS[level]["name"], string.format(text, ...)))
end

function Logger:Error(text, ...)
    self:PrintMessage(1, text, ...)
end

function Logger:Warning(text, ...)
    self:PrintMessage(2, text, ...)
end

function Logger:Info(text, ...)
    self:PrintMessage(3, text, ...)
end

function Logger:Debug(text, ...)
    self:PrintMessage(4, text, ...)
end

FlexCommand.logging.CreateLogger = function(level)
    local obj = {}
    setmetatable(obj, Logger)
    obj.level = level or Logger.level

    return obj
end

FlexCommand.logging.GetDefaultLogger = function()
    return defaultLogger
end

FlexCommand.logging.SetDefaultLogger = function(logger)
    defaultLogger = logger
end

FlexCommand.logging.PrintError = function(text, ...)
    defaultLogger:Error(text, ...)
end

FlexCommand.logging.PrintWarning = function(text, ...)
    defaultLogger:Warning(text, ...)
end

FlexCommand.logging.PrintInfo = function(text, ...)
    defaultLogger:Info(text, ...)
end

FlexCommand.logging.PrintDebug = function(text, ...)
    defaultLogger:Debug(text, ...)
end

