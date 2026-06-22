local mainMod = "SUPER" -- Sets "Windows" key as main modifier

local menu     = "rofi -show combi -combi-modes window,drun,run,filebrowser -modes combi"
local terminal = "kitty"
local browser  = "firefox"
local filemanager  = "thunar" -- dplphin, thunar

-- Quit hyprland
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Application launchers
hl.bind(mainMod .. " + Return",         hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + I",      hl.dsp.exec_cmd("emacs"))
hl.bind(mainMod .. " + SHIFT + B",      hl.dsp.exec_cmd(browser))

hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd(filemanager))
hl.bind(mainMod .. " + SHIFT + T",      hl.dsp.exec_cmd(terminal .. " btop"))

-- Window management
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
hl.bind(mainMod .. " + S",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen())

-- Screenshot
hl.bind(mainMod .. " + CTRL + S",  hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hyprshot -m window"))

-- Clipboard
-- yay -S clipvault
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("clipvault list | rofi -dmenu -display-columns 2 | clipvault get | wl-copy"))

-- Cycle focus
hl.bind(mainMod .. " + K",   hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + J",   hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ last = true}))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT/CTRL + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0

    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))

    -- First 8 workspaces use SHIFT, last 2 use CTRL
    if i <= 8 then
        hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    else
        hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i }))
    end
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize submap: enter with mainMod + SHIFT + R
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    hl.bind("l", hl.dsp.window.resize({ x = 10,  y = 0,  relative = true }), { repeating = true })
    hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0,  relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)
