local menuengine = require "menuengine"
local function MenuStart()
  gamestate = 1
end

local function MenuQuit()
  os.exit()
end

local function MenuSettings()
gamestate = 2
end

function Size()
  if MinesInLine == 3 then MinesInLine = 4
  elseif MinesInLine == 4 then MinesInLine = 5
  elseif MinesInLine == 5 then MinesInLine = 3 end
end

function gamemodeChanger()
  if gamemode == 'P vs C' then gamemode = 'P vs P'
  elseif gamemode == 'P vs P' then gamemode = 'C vs C'
  elseif gamemode == 'C vs C' then gamemode = 'P vs C'
  end
  end

function MainMenuCreate()
    love.graphics.setFont(love.graphics.newFont(80))
    local mainmenu = menuengine.new(0,100)
    mainmenu:addEntry("Start Game", MenuStart)
    mainmenu:addEntry("Options",  MenuSettings)
    mainmenu:addSep()
    mainmenu:addEntry("Quit Game", MenuQuit)
    return mainmenu
  end
  
  function SettingsMenuCreate()
    love.graphics.setFont(love.graphics.newFont(80))
    local mainmenu = menuengine.new(0,100)
    mainmenu:addEntry("Mode", gamemodeChanger)
    mainmenu:addEntry("Size: ",Size)
    mainmenu:addSep()
    mainmenu:addEntry("Back", function() gamestate = 0 end)
    return mainmenu
  end