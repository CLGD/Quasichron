-- modules/painter.lua
-- a module that paints things

-- localisation of globals
local sqrt = math.sqrt
local abs = math.abs
local sin = math.sin
local cos = math.cos
local rad = math.rad
local expect = quasichron.expect

local painter = quasichron.class(function(self, target)
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

return painter