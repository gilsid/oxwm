-- Fixture for spawn-table argument extraction tests.
-- Every element of the table must reach the spawned command.
oxwm.key.bind({ "Mod4" }, "Return", oxwm.spawn({ "screenshot.sh", "area" }))
oxwm.key.bind({ "Mod4" }, "D", oxwm.spawn({ "notify-send", "hello world" }))
oxwm.key.bind({ "Mod4" }, "F", oxwm.spawn({ "prog", "it's" }))
oxwm.key.bind({ "Mod4" }, "S", oxwm.spawn({ "sh", "-c", "dmenu_run -l 10" }))
oxwm.key.bind({ "Mod4" }, "Q", oxwm.spawn({ "st" }))
