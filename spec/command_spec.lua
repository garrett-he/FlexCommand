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
end)
