-- Register slash commands
_G["SLASH_FLEXCOMMAND1"] = "/flexcommand"
_G["SLASH_FLEXCOMMAND2"] = "/fc"

SlashCmdList["FLEXCOMMAND"] = function(str)
    if str == "" then
        str = "help"
    end

    FC_ExecuteString(str)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function(_, _, isInitialLogin, isReloadingUi, ...)
    if isInitialLogin or isReloadingUi then
        local logger = FC_CreateLogger(FC_GetConfig("logLevel", 3))
        FC_SetDefaultLogger(logger)

        local profiles = FC_GetAllRegisteredProfiles()

        for name, profile in pairs(profiles) do
            if profile["autoload"] then
                FC_LoadProfile(name)
            end
        end
    end
end)
