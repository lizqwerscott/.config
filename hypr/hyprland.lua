-- https://wiki.hypr.land/Configuring/Basics/Monitors/

-- 中间 4k 主屏幕
hl.monitor({
  output = "DP-4",
  mode = "3840x2160@160",
  position = "2560x0",
  scale = 1,
})

-- 左边 2K 屏幕
hl.monitor({
  output = "DP-5",
  mode = "2560x1440@140",
  position = "0x0",
  scale = 1,
})

local main_window = "DP-4"
local left_window = "DP-5"

-- 工作区分配：1,2,3 → DP-4（主屏）；4,5,6,7,8,9 → DP-5（左屏）
for i = 1, 3 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = main_window,
        default = (i == 1),
    })
end

for i = 4, 9 do
    hl.workspace_rule({ workspace = tostring(i), monitor = left_window })
end

require("execs")
require("env")
require("general")
require("rules")
require("keybinds")
