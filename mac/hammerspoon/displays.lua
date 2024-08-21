inputDevice="Anker PowerConf C200"
outputDevice="LG Ultra HD"
headphones="Realtek USB2.0 Audio"
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
wWatcher= hs.screen.watcher.new(windowWatcher):start()
