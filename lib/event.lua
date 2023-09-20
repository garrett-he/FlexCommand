local _, FlexCommand = ...

FlexCommand.event = {}

-- Registered events and associated handlers
local registeredEvents = {}

FlexCommand.event.RegisterEvent = function(event, handler)
    if not registeredEvents[event] then
        registeredEvents[event] = {}
    end

    table.insert(registeredEvents[event], handler)
end

FlexCommand.event.RaiseEvent = function(event, ...)
    if not registeredEvents[event] or #registeredEvents[event] == 0 then
        return true
    end

    for _, handler in pairs(registeredEvents[event]) do
        if handler(...) == false then
            return false
        end
    end

    return true
end
