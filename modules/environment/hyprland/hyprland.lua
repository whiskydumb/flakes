hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.config({
    general = {
        gaps_in = 5, gaps_out = 10, border_size = 1, resize_on_border = true,
        col = { active_border = "rgb(444444)", inactive_border = "rgb(2b2b2b)" },
    },
    decoration = { rounding = 12, blur = { enabled = false } },
    input = { kb_layout = "us,ru", kb_options = "grp:alt_shift_toggle", follow_mouse = 0 },
    misc = { disable_hyprland_logo = true, disable_splash_rendering = true },
})

hl.window_rule({ name = "floating-default", match = { class = ".*" }, float = true })

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("uwsm app -- ghostty"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("vicinae deeplink vicinae://launch/clipboard/history"))
hl.bind("SUPER + A", hl.dsp.exec_cmd("uwsm app -- pwvucontrol"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
