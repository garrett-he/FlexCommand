local _, FlexCommand = ...

-- Register slash commands
_G["SLASH_FLEXCOMMAND1"] = "/flexcommand"
_G["SLASH_FLEXCOMMAND2"] = "/fc"

SlashCmdList["FLEXCOMMAND"] = function(str)
    if str == "" then
        str = "help"
    end

    FlexCommand.command.ExecuteCommand(FlexCommand.command.ParseCommand(str))
end
