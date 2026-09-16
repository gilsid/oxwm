const std = @import("std");
const testing = std.testing;
const lua = @import("lua");
const Config = lua.config_mod.Config;

test "test-config.lua loads without errors" {
    var cfg = Config.init(testing.allocator);
    defer cfg.deinit();

    const initialized = lua.init(&cfg);
    if (!initialized) {
        return error.LuaInitFailed;
    }
    defer lua.deinit();

    const loaded = lua.loadFile("resources/test-config.lua");
    try testing.expect(loaded);
}

test "spawn tables keep every argument" {
    var cfg = Config.init(testing.allocator);
    defer cfg.deinit();

    const initialized = lua.init(&cfg);
    if (!initialized) {
        return error.LuaInitFailed;
    }
    defer lua.deinit();

    const loaded = lua.loadFile("resources/test-spawn-args.lua");
    try testing.expect(loaded);
    try testing.expectEqual(@as(usize, 5), cfg.keybinds.items.len);

    const wants = [_][]const u8{
        "screenshot.sh area",
        "notify-send 'hello world'",
        "prog 'it'\\''s'",
        "dmenu_run -l 10",
        "st",
    };
    for (cfg.keybinds.items, wants) |keybind, want| {
        const got = keybind.str_arg orelse return error.MissingSpawnCommand;
        try testing.expectEqualStrings(want, got);
    }
}
