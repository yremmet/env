--- Iterm
FocusedWindow = nil
L = hs.logger.new('focus', 'debug')
function iterm()
    focus("iTerm2", "iterm")
end
function obsidian()
    focus("Obsidian")
end

function focus(app, name2)
    L.d(app)
    if (name2 == nil)then
        name2=app
    end
    fw =hs.window.focusedWindow()
    focusedApp = fw:application():title()
    if (focusedApp == app) then
        -- hyperfocus app is already focused get original window back
        if (FocusedWindow) then
            FocusedWindow:focus()
            FocusedWindow = nil
        end
    else
        -- focus ob hyperfocus app
        if (FocusedWindow == nil) then
            FocusedWindow = hs.window.focusedWindow()
        end
        hs.application.launchOrFocus(name2)
    end
end
    

local hyperMode = hs.hotkey.bind({'cmd','shift' }, '1',  function() focus("iTerm2", "iterm") end)
local hyperMode = hs.hotkey.bind({'cmd','shift' }, '2',  function() focus("Obsidian") end)
