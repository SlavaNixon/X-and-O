require("button")
local menuengine = require "menuengine"
require ('menu_fun')
require('media')
require('gamerules')

function winChecker(char)
  --[[
  for j = 1,MinesInLine^2,MinesInLine do
    local t = {}
    local flag = 0
  for i = j,j+MinesInLine-1 do
    t[i] = buttons[i].text
  end
  for n,m in pairs(t) do
    for a,b in pairs(t) do
      if m ~= b then flag = 1 end
      end
    end
  end
  if flag == 0 then print(1) end
  --]]
end

function love.load()
  love.window.setMode(600,700)
  photo = createImages()
  gamestate = 0
  MinesInLine = 3
  gamemode = 'P vs C'
  w, h = love.window.getMode()
  mainmenu = MainMenuCreate()
  settingsmenu = SettingsMenuCreate()
  createCells()
end

function love.draw()
      love.graphics.setColor(1,1,0)
  if gamestate == 0 then love.graphics.draw(photo.back,0,0); mainmenu:draw(); randomphoto = love.math.random(6)  end
  if gamestate == 1 then
    love.graphics.clear()
    love.graphics.draw(photo[randomphoto],0,0)
    drawButtons()
    love.graphics.setColor(0.01,1,0.12)
    love.graphics.setFont(love.graphics.newFont(70))
    if gamemode == 'P vs P' then
      if CellsOpend() % 2 == 1 then love.graphics.print('Player 1 turn')
      else
      love.graphics.print('Player 2 turn')
      end
      end
    end
  if gamestate == 2 then
    love.graphics.draw(photo.back,0,0)
    settingsmenu:draw()
    love.graphics.setFont(love.graphics.newFont(80))
    love.graphics.print(MinesInLine..'x'..MinesInLine,350,200)
    love.graphics.print(gamemode,350,100)
    createCells()
    end
end

function love.update()
  if gamestate == 0 then mainmenu:update() end
  --if gamestate == 1 then winChecker() end
  if gamestate == 2 then settingsmenu:update() end
  end

function love.mousepressed( x, y, button, istouch )
  if button==1 and gamestate ==1 then updateButtons(x,y) end
end

function love.mousemoved(x, y, dx, dy, istouch)
    menuengine.mousemoved(x, y)
end

function love.keypressed(key, scancode, isrepeat)
    menuengine.keypressed(scancode)
    if scancode == 'escape' then gamestate = 0 end
    end