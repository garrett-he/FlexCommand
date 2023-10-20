require("spec.helper")

local FlexCommand = {}

loadlib(FlexCommand, "event")

describe("FlexCommand.event module", function()
    describe("RaiseEvent() function", function()
        it("should execute handler functions on event.", function()
            local fn1 = spy.new(function()
            end)

            local fn2 = spy.new(function()
                return true
            end)

            local fn3 = spy.new(function()
                return false
            end)

            local fn4 = spy.new(function()
            end)

            -- Should return true if event not registered.
            assert.is_true(FlexCommand.event.RaiseEvent("UNREGISTERED_EVENT"))

            FlexCommand.event.RegisterEvent("EVENT", fn1)
            FlexCommand.event.RegisterEvent("EVENT", fn2)

            assert.is_true(FlexCommand.event.RaiseEvent("EVENT", "PARAM1", "PARAM2"))

            assert.spy(fn1).was_called_with("PARAM1", "PARAM2")
            assert.spy(fn2).was_called_with("PARAM1", "PARAM2")

            FlexCommand.event.RegisterEvent("EVENT", fn3)
            FlexCommand.event.RegisterEvent("EVENT", fn4)

            assert.is_false(FlexCommand.event.RaiseEvent("EVENT", "PARAM1", "PARAM2"))
            assert.spy(fn4).was_not_called_with("PARAM1", "PARAM2")
        end)
    end)
end)
