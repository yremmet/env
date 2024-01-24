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

inputDevice="Anker PowerConf C200"
outputDevice="LG Ultra HD"
headphones="External Headphones"
interal=true
function windowWatcher()
    l = hs.logger.new('display', 'debug')
    mainScreen = hs.screen.mainScreen()
    if ("Built-in Retina Display" == mainScreen:name()) then
      if (not internal) then
         l.i("Running internal workflow")
         hs.alert("Retina")
         internal=true
         hs.osascript.applescript("tell application \"System Events\" to tell dock preferences\n set screen edge to left\n end tell")
      end
    else
      if (internal) then
        internal=false
        l.i("Running external workflow")
        hs.alert("External Display")
        hs.osascript.applescript("tell application \"System Events\" to tell dock preferences\n set screen edge to right\n end tell")
        od = hs.audiodevice.findOutputByName(outputDevice)
        eh = hs.audiodevice.findOutputByName(headphones)

        if (not eh and od) then
          od:setDefaultOutputDevice()
        end
        if (eh) then
          eh:setDefaultOutputDevice()
        end
        id = hs.audiodevice.findInputByName(inputDevice)
        if (id) then
          id:setDefaultInputDevice()
        end
      end
    end
end

--- Watcher
wWatcher= hs.screen.watcher.new(windowWatcher):start()
cWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/Downloads/", citrix):start()
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

--- Window Manager
hs.loadSpoon("ShiftIt")
local obj = {
  hs = hs
}
obj.mash = { 'ctrl', 'alt'}
obj.mapping = {
  left = { obj.mash, 'left' },
  right = { obj.mash, 'right' },
  up = { obj.mash, 'up' },
  down = { obj.mash, 'down' },
  upleft = { obj.mash, '1' },
  upright = { obj.mash, '2' },
  botleft = { obj.mash, '3' },
  botright = { obj.mash, '4' },
  maximum = { obj.mash, 'return' },
  toggleFullScreen = { obj.mash, 'f' },
  toggleZoom = { obj.mash, 'z' },
  center = { obj.mash, 'c' },
  nextScreen = { obj.mash, 'n' },
  previousScreen = { obj.mash, 'p' },
  resizeOut = { obj.mash, '=' },
  resizeIn = { obj.mash, '-' },
}
spoon.ShiftIt:bindHotkeys(obj.mapping)

--- Iterm
FocusedWindow = nil
L = hs.logger.new('focus', 'debug')
function enterHyperMode()
    fw =hs.window.focusedWindow()
    app = fw:application():title()
    if (app == "iTerm2") then
      L.d(FocusedWindow)
      if (FocusedWindow) then
        FocusedWindow:focus()
      end
    else
      FocusedWindow = hs.window.focusedWindow()
      hs.application.launchOrFocus("iTerm")
    end
end

function exitHyperMode()
end

local hyperMode = hs.hotkey.bind({'cmd','shift' }, '1', enterHyperMode, exitHyperMode)
--- Cookie
function getCookie()
  m,body,headers = hs.http.get("http://www.yerkee.com/api/fortune")
  fortune = hs.json.decode(body).fortune
  x = math.random(1,6) * 100
  y = math.random(1,6) * 100

  image = hs.image.imageFromURL("https://place-puppy.com/".. x .. "x" .. y)

  hs.alert.showWithImage(fortune, image, nil, nil, 10)
end

local cookie = hs.hotkey.bind({}, 'F2', getCookie, nil)
hs.alert.show("Config loaded")
