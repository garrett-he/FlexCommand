require("spec.helper")

local FlexCommand = {}

loadlib(FlexCommand, "profile")

describe("FlexCommand.profile module", function()
    local registeredProfiles = FlexCommand.profile.GetAllRegisteredProfiles()

    describe("RegisterProfile() function", function()
        it("should register a new profile.", function()
            local profile = {}

            FlexCommand.profile.RegisterProfile("test-profile", profile)

            assert.is_not_nil(registeredProfiles["test-profile"])

            FlexCommand.profile.UnregisterProfile("test-profile")
            assert.is_nil(registeredProfiles["test-profile"])
        end)

        it("should raise an error if profile already registered.", function()
            local profile = {}

            FlexCommand.profile.RegisterProfile("test-profile", profile)

            assert.has_error(function()
                FlexCommand.profile.RegisterProfile("test-profile", profile)
            end, "Profile 'test-profile' already exists.")
        end)
    end)

    describe("UnregisterProfile() function", function()
        it("should raise an error if profile not registered yet.", function()
            assert.has_error(function()
                FlexCommand.profile.UnregisterProfile("non-existing-profile")
            end, "Profile 'non-existing-profile' not registered yet.")
        end)
    end)
end)
