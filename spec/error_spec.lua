require("spec.helper")

local FlexCommand = {}

loadlib(FlexCommand, "error")

describe("FlexCommand.error module", function()
    it("should be able to get and set the last-error message.", function()
        -- Last-error message defaults to nil
        assert.is_nil(FlexCommand.error.GetLastError())

        local msg1 = "Test error message."
        assert.is_nil(FlexCommand.error.SetLastError(msg1))

        assert.are.equal(msg1, FlexCommand.error.GetLastError())

        -- Error message won't be change after multiple GetLastError()
        assert.are.equal(msg1, FlexCommand.error.GetLastError())

        local msg2 = "Another test error message."
        FlexCommand.error.SetLastError(msg2)
        assert.are.equal(msg2, FlexCommand.error.GetLastError())
    end)
end)
