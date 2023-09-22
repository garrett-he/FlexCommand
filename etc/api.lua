local _, FlexCommand = ...

-- FlexCommand.config module
FC_GetConfig = FlexCommand.config.GetConfig
FC_SetConfig = FlexCommand.config.SetConfig

-- FlexCommand.command module
FC_RegisterCommand = FlexCommand.command.RegisterCommand
FC_UnregisterCommand = FlexCommand.command.UnregisterCommand
FC_GetAllRegisteredCommands = FlexCommand.command.GetAllRegisteredCommands
FC_ExecuteString = FlexCommand.command.ExecuteString

-- FlexCommand.logging module
FC_CreateLogger = FlexCommand.logging.CreateLogger
FC_GetDefaultLogger = FlexCommand.logging.GetDefaultLogger
FC_SetDefaultLogger = FlexCommand.logging.SetDefaultLogger
FC_PrintError = FlexCommand.logging.PrintError
FC_PrintWarning = FlexCommand.logging.PrintWarning
FC_PrintInfo = FlexCommand.logging.PrintInfo
FC_PrintDebug = FlexCommand.logging.PrintDebug
