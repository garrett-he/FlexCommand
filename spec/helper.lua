function loadlib(tb, name)
    loadfile(string.format("lib/%s.lua", name))("FlexCommand", tb)
end
