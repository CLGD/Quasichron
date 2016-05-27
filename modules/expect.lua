-- modules/expect.lua
-- a utility module for function arguments

local expect = nil

do
    if system and system.expect then -- Radium
        expect = system.expect
    elseif _G.expect then -- Bench
        expect = _G.expect
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
end

return expect