require("spec.helper")

local FlexCommand = {}

loadlib(FlexCommand, "logging")

describe("FlexCommand.logging module", function()
    stub(_G, "print")
    FlexCommand.config = {
        GetConfig = function(key, default)
            return default
        end
    }

    FlexCommand.logging.SetDefaultLogger(FlexCommand.logging.CreateLogger(FlexCommand.config.GetConfig("logLevel", 3)))

    describe("CreateLogger() function", function()
        it("should create and return logger object.", function()
            local logger1 = FlexCommand.logging.CreateLogger()

            assert.is_not_nil(logger1)
            assert.are_equal("function", type(logger1.Error))
            assert.are_equal(3, logger1.level)

            local logger2 = FlexCommand.logging.CreateLogger(4)
            assert.are_equal(4, logger2.level)
            assert.are_equal(3, logger1.level)
        end)
    end)

    describe("Logger class", function()
        local logger = FlexCommand.logging.CreateLogger()

        describe("Error() method", function()
            it("should print error messages.", function()
                local msg = "The error message"
                logger:Error(msg)

                assert.stub(print).was.called_with(string.format("|c%s[FlexCommand][%s]: %s|r", "ffff0000", "ERROR", msg))
            end)
        end)

        describe("Warning() function", function()
            it("should print warning messages.", function()
                local msg = "The warning message"
                logger:Warning(msg)

                assert.stub(print).was.called_with(string.format("|c%s[FlexCommand][%s]: %s|r", "ffff9900", "WARNING", msg))
            end)
        end)

        describe("Info() function", function()
            it("should print information messages.", function()
                local msg = "The information message"
                logger:Info(msg)

                assert.stub(print).was.called_with(string.format("|c%s[FlexCommand][%s]: %s|r", "ffffffff", "INFO", msg))
            end)
        end)

        describe("Debug() function", function()
            it("should print debug messages.", function()
                logger.level = 4

                local msg = "The debug message"
                logger:Debug(msg)

                assert.stub(print).was.called_with(string.format("|c%s[FlexCommand][%s]: %s|r", "ff00ffff", "DEBUG", msg))
            end)
        end)
    end)

    describe("Functions by using default logger", function()
        local logger = FlexCommand.logging.GetDefaultLogger()

        stub(logger, "Error")
        stub(logger, "Warning")
        stub(logger, "Info")
        stub(logger, "Debug")

        describe("PrintError() function", function()
            it("should print error messages by using default logger.", function()
                local msg = "The error message"

                FlexCommand.logging.PrintError(msg)
                assert.stub(logger.Error).was_called_with(logger, msg)
            end)
        end)

        describe("PrintWarning() function", function()
            it("should print warning messages by using default logger.", function()
                local msg = "The warning message"

                FlexCommand.logging.PrintWarning(msg)
                assert.stub(logger.Warning).was_called_with(logger, msg)
            end)
        end)

        describe("PrintInfo() function", function()
            it("should print info messages by using default logger.", function()
                local msg = "The info message"

                FlexCommand.logging.PrintInfo(msg)
                assert.stub(logger.Info).was_called_with(logger, msg)
            end)
        end)

        describe("PrintDebug() function", function()
            it("should print debug messages by using default logger.", function()
                local msg = "The debug message"

                FlexCommand.logging.PrintDebug(msg)
                assert.stub(logger.Debug).was_called_with(logger, msg)
            end)
        end)
    end)
end)
