-- modules/class.lua
-- a helper for oop stuff

local function class(constructor, base)
    local tbl = {}
    tbl.__index = tbl
    
    setmetatable(tbl, {
        __call = function(tbl, ...)
            local self = setmetatable({}, tbl)
            constructor(self, ...)
            return self
        end,
        
        __index = base
    })
    
    return tbl
end

return class