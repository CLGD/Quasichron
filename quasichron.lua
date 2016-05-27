local shell = ...
local module = {}

local modules = {
    "expect.lua",
    "class.lua",
    "animate.lua",
    "painter.lua"
}

do
    for _,v in pairs(modules) do
        local modName = v:match("(.+)%.lua")
        if modName == nil then modName = v end
        
        local env = setmetatable({ quasichron = module }, { __index = _G })
        local mod, err = loadfile(shell.resolve(fs.combine("modules", v)), env)
        if mod == nil then
            error(err, 1)
            return
        end
        
        module[modName] = mod()
    end
end

return module