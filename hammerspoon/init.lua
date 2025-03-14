-- Enable AppleScript control for external scripts
hs.allowAppleScript(true)

-- Global Play/Pause hotkey (Cmd + Shift + Ctrl + P)
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "P", function()
	hs.eventtap.event.newSystemKeyEvent("PLAY", true):post()
	hs.eventtap.event.newSystemKeyEvent("PLAY", false):post()
end)
