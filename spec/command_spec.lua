require("spec.helper")

local FlexCommand = {}

loadlib(FlexCommand, "command")

describe("FlexCommand.command module", function()
    describe("ParseCommand() function", function()
        it("should parse and return commands.", function()
            local command, args = FlexCommand.command.ParseCommand("cmd1")

            assert.are_equal("cmd1", command)
            assert.are_same({}, args)
        end)

        it("should parse and return commands with parameters", function()
            local str = "cmd2 key1=10086 key2=100.86 key3=true key4=false key5='single quoted' key6=\"double quoted\" key7=not-quoted key8=nil key9="
            local command, args = FlexCommand.command.ParseCommand(str)

            assert.are_equal("cmd2", command)
            assert.are_equal(10086, args["key1"])
            assert.are_equal(100.86, args["key2"])
            assert.is_true(args["key3"])
            assert.is_false(args["key4"])
            assert.are_equal("single quoted", args["key5"])
            assert.are_equal("double quoted", args["key6"])
            assert.are_equal("not-quoted", args["key7"])
            assert.is_nil(args["key8"])
            assert.is_nil(args["key9"])
        end)
    end)

    local registeredCommands = FlexCommand.command.GetAllRegisteredCommands()

    describe("RegisterCommand() function", function()
        it("should be able to register commands.", function()
            local help = "help info"
            local handler = function()
            end

            assert.is_nil(registeredCommands["cmd"])
            FlexCommand.command.RegisterCommand("cmd", help, handler)

            assert.are_equal(help, registeredCommands["cmd"]["help"])
            assert.are_equal(handler, registeredCommands["cmd"]["handler"])
        end)

        it("should raise an error if command already registered.", function()
            assert.is_not_nil(registeredCommands["cmd"])
            assert.has_error(function()
                FlexCommand.command.RegisterCommand("cmd", {})
            end, "Command 'cmd' already registered.")
        end)
    end)

    describe("UnregisterCommand() function", function()
        it("should be able to unregister commands.", function()
            assert.is_not_nil(registeredCommands["cmd"])

            FlexCommand.command.UnregisterCommand("cmd")
            assert.is_nil(registeredCommands["cmd"])
        end)

        it("should raise an error if command not registered yet.", function()
            assert.is_nil(registeredCommands["cmd"])

            assert.has_error(function()
                FlexCommand.command.UnregisterCommand("cmd")
            end, "Command 'cmd' not registered yet.")
        end)
    end)

    describe("ExecuteCommand() function", function()
        it("should raise an error if command not registered.", function()
            assert.has_error(function()
                FlexCommand.command.ExecuteCommand("non-existing-cmd")
            end, "Command 'non-existing-cmd' not registered yet.")
        end)

        it("should execute commands with arguments.", function()
            local spec = {
                handler = function()
                    return true
                end
            }

            spy.on(spec, "handler")

            FlexCommand.command.RegisterCommand("cmd", "test command", spec.handler)

            local command, args = FlexCommand.command.ParseCommand("cmd key1=value1")

            assert.is_true(FlexCommand.command.ExecuteCommand(command, args))
            assert.spy(spec.handler).was_called_with({ key1 = "value1" }, nil)

            FlexCommand.command.UnregisterCommand("cmd")
        end)
    end)
end)
