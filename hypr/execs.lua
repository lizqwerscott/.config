hl.on("hyprland.start", function ()
  hl.exec_cmd("~/.config/scripts/checkupdates.sh")

  -- wallpaper, Bar
  -- hl.exec_cmd("~/.config/hypr/scripts/background-video.sh")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("waybar")

  -- Input method
  hl.exec_cmd("fcitx5 --replace -d")

  -- Clipboard (use clipvault)
  hl.exec_cmd("wl-paste --watch clipvault store")

  -- Bluetooth, notification
  -- hl.exec_cmd("blueman-tray")
  hl.exec_cmd("swaync")

  -- hl.exec_cmd("browserpass")
end)
