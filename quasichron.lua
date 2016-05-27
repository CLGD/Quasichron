local module = {}

-- localisation of globals
local sqrt = math.sqrt
local abs = math.abs
local sin = math.sin
local cos = math.cos
local rad = math.rad

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

local expect = nil

if system and system.expect then
    expect = system.expect
else
    expect = function(arg, typ, n, optional, level)
        if type(arg) ~= typ and not optional then
		    return error(("expected %s, got %s for arg %i"):format(typ, type(arg), n), level or 2)
	    elseif type(arg) ~= typ and arg ~= nil and optional then
		    return error(("expected %s or nil, got %s for arg %i"):format(typ, type(arg), n), level or 2)
	    end
        
	    return arg
    end
end

local painter = class(function(self, target)
    self.target = target
end)

local function verifyDrawArgs(x, y, w, h, colour, hollow)
    expect(x, "number", 1, false)
    expect(y, "number", 2, false)
    expect(w, "number", 3, false)
    expect(h, "number", 4, false)
    expect(colour, "number", 5, false)
    expect(hollow, "boolean", 6, true)
end

function painter:rectangle(x, y, w, h, colour, hollow)
    verifyDrawArgs(x, y, w, h, colour, hollow)
    if hollow == nil then hollow = false end

    local target = self.target
    target.setBackgroundColour(colour)

    for _x=x,x+w do
        for _y=y,y+h do
            if hollow then
                if (_x == x or _x == x + w) or (_y == y or _y == y + h) then
                    target.setCursorPos(_x, _y)
                    target.write(" ")
                end 
            else
                target.setCursorPos(_x, _y)
                target.write(" ")
            end
        end
    end
end

module.painter = painter
return module