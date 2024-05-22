-- full 
hs.hotkey.bind({'alt', 'cmd'}, 'return', function() hs.window.focusedWindow():moveToUnit({0, 0, 1, 1}) end)
-- center
hs.hotkey.bind({'alt', 'cmd'}, '+', function() hs.window.focusedWindow():moveToUnit({0.25, 0.25, 0.5, 0.5}) end)

-- half screen
hs.hotkey.bind({'alt', 'cmd'}, 'left', function() hs.window.focusedWindow():moveToUnit({0.0, 0.0, 0.5, 1}) end)
hs.hotkey.bind({'alt', 'cmd'}, 'right', function() hs.window.focusedWindow():moveToUnit({0.5, 0.0, 1, 1}) end)
hs.hotkey.bind({'alt', 'cmd'}, 'up', function() hs.window.focusedWindow():moveToUnit({0.0, 0.0, 1, 0.5}) end)
hs.hotkey.bind({'alt', 'cmd'}, 'down', function() hs.window.focusedWindow():moveToUnit({0.0, 0.5, 1, 1}) end)
-- quater screen
hs.hotkey.bind({'alt', 'cmd'}, 'h', function() hs.window.focusedWindow():moveToUnit({0.0, 0.0, 0.5, 0.5}) end)
hs.hotkey.bind({'alt', 'cmd'}, 'j', function() hs.window.focusedWindow():moveToUnit({0.5, 0.0, 1, 0.5}) end)
hs.hotkey.bind({'alt', 'cmd'}, 'k', function() hs.window.focusedWindow():moveToUnit({0.0, 0.5, 0.5, 1}) end)
hs.hotkey.bind({'alt', 'cmd'}, 'l', function() hs.window.focusedWindow():moveToUnit({0.5, 0.5, 1, 1}) end)

