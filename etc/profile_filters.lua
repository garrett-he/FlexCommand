local _, FlexCommand = ...

FC_RegisterProfileFilter("classes", function(args)
    return tContains(args, UnitClass("player"))
end)

FC_RegisterProfileFilter("characters", function(args)
    return tContains(args, UnitName("player"))
end)

FC_RegisterProfileFilter("instances", function(args)
    local _, instanceType = IsInInstance()
    return tContains(args, instanceType)
end)

FC_RegisterProfileFilter("races", function(args)
    return tContains(args, UnitRace("player"))
end)

FC_RegisterProfileFilter("realms", function(args)
    return tContains(args, GetRealmName())
end)

FC_RegisterProfileFilter("talents", function(args)
    local _, name = GetSpecializationInfo(GetSpecialization())
    return tContains(args, name)
end)

FC_RegisterProfileFilter("expansions", function(args)
    return tContains(args, GetExpansionLevel())
end)
