hs=hs
spoon=spoon
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function reloadConfig(files)
    doReload = false
    if files == nil then
      doReload = true
    else
      for _,file in pairs(files) do
          if file:sub(-4) == ".lua" then
              doReload = true
          end
      end
    end
    if doReload then
        hs.reload()
    end
end


function citrix(files)
    l = hs.logger.new('citrx', 'debug')
    l.i("Triggerd citrix workflow")
    for _,file in pairs(files) do
        l.i("File")
        if file:sub(-4) == ".ica" then
            l.i(file)
            hs.execute("open " .. file)
            hs.execute("sleep 5; rm -f " .. file) 
        end
    end
end



-- Display IO 
require('displays')
--- Watcher
--- cWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/Downloads/", citrix):start() -- diabled weil kein citrix 
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

--- Window Manager
--require('window')
require('iterm')

function teams_step_one()
  l = hs.logger.new('teams', 'debug')
  l.i("Triggerd teams workflow")
  hs.osascript.applescript("activate application \"Microsoft Teams (work or school)\"\ndelay 2\ntell application \"System Events\" to keystroke \"N\" using {shift down, command down}\ndelay 1.5\ntell application \"System Events\" to keystroke \"yannic remmet\" using {shift down}\ndelay 1\ntell application \"System Events\" to key code 36")
end
---


--local cookie = hs.hotkey.bind({}, 'F2', getCookie, nil)
--local teams = hs.hotkey.bind({'cmd', 'shift', 'alt' }, '+', teams_step_one, nil)
hs.alert.show("Config loaded")
