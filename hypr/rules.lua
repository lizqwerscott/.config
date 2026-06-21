-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- Emacs: workspace 1, fullscreen
hl.window_rule({
    name  = "emacs",
    match = { title = ".*Emacs.*" },

    workspace  = "1",
    fullscreen = true,
})

-- Firefox: workspace 4
hl.window_rule({
    name  = "firefox",
    match = { class = "firefox" },

    workspace = "4",
})

-- Discord: workspace 5
hl.window_rule({
    name  = "discord",
    match = { title = ".*Discord" },

    workspace = "5",
})

-- QQ: workspace 5
hl.window_rule({
    name  = "qq",
    match = { title = ".*QQ.*" },

    workspace = "5",
})

-- LocalSend: workspace 8
hl.window_rule({
    name  = "localsend",
    match = { title = "LocalSend" },

    workspace = "8",
})

-- AudioRelay: workspace 9
hl.window_rule({
    name  = "audiorelay",
    match = { title = "AudioRelay" },

    workspace = "9",
})

-- Volume Control: float, center, 50% size
hl.window_rule({
    name  = "volume-control",
    match = { title = ".*Volume Control.*" },

    float  = true,
    center = true,
    size   = "(monitor_w*0.5) (monitor_h*0.5)",
})
