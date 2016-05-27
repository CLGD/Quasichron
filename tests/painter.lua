local quasichron, err = loadfile(shell.resolve("quasichron.lua"))(shell)
if quasichron == nil then
    error(err, 0)
end

local painter = quasichron.painter(term.current())
painter:rectangle(1, 1, 5, 5, colours.red, true)
painter:rectangle(7, 1, 5, 5, colours.lime, false)