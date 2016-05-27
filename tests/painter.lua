local quasichron = dofile(shell.resolve("quasichron.lua"))
local painter = quasichron.painter(term.current())
painter:rectangle(1, 1, 5, 5, colours.red, true)
painter:rectangle(7, 1, 5, 5, colours.lime, false)