require("button")
local menuengine = require "menuengine"
require ('menu_fun')
require('media')
require('gamerules')

function DrawWinMessage()
  if winCheck and gamemode == 'P vs P' then love.graphics.print('Win '..winPlayer..' player',70,300) end
  if winCheck and gamemode == 'P vs C' then
    if Computer ~= Turn() then love.graphics.print('Computer win',70,300)
    else love.graphics.print('Player win',70,300) end
    end
      if not winCheck and CellsOpend() == MinesInLine^2 then
        love.graphics.setColor(0.8,0.8,0.8)
        love.graphics.print('Draw',210,300) 
        love.graphics.setColor(0.01,1,0.12)
      end
  end

function Turn()
   if CellsOpend() % 2 == 0 then return 'X' end
   if CellsOpend() % 2 == 1 then return 'O' end
  end

function CopyButtons()
  local t ={}
  for i = 1, MinesInLine^2 do
    t[i] = buttons[i]
  end
  return t
  end

function CompAI(char,cells,player)
  if char == cells then
  
  for i=1,MinesInLine^2 do  -- если может выиграть ставит клетку
    t = CopyButtons()
    if t[i].text == '' then 
      t[i].text = char
      if winChecker(t) then return i
      else t[i].text = '' end
      end
    end
    
    for i=1,MinesInLine^2 do -- если противник может выиграть ставит клетку
    t = CopyButtons()
    if t[i].text == '' then 
      t[i].text = player
      if winChecker(t) then t[i].text = char return i
      else t[i].text = '' end
      end
    end
    
    t = CopyButtons()  -- если центр не занят, занимает центр
    
    if MinesInLine % 2 == 1 then
    if t[((MinesInLine^2)+1)/2].text == '' then t[((MinesInLine^2)+1)/2].text = char return i end
  end
    if MinesInLine % 2 == 0 then
      if t[6].text == '' then t[6].text = char return 6 end
      if t[7].text == '' then t[7].text = char return 7 end
      if t[10].text == '' then t[10].text = char return 10 end
      if t[11].text == '' then t[11].text = char return 11 end
      end
    t = CopyButtons()
    if t[1].text =='' and t[MinesInLine^2].text =='' then
      for i = 2,MinesInLine do
        if t[i].text ~= '' then goto point1; end
      end
      t[1].text = char
      return 1
    end
    ::point1::
    
    t = CopyButtons()
    if t[MinesInLine^2-MinesInLine+1].text =='' and t[MinesInLine].text =='' then
      for i = MinesInLine^2-MinesInLine+1,MinesInLine^2 do
        if t[i].text ~= '' then goto point2; end
      end
      t[MinesInLine^2-MinesInLine+1].text = char;
      return MinesInLine^2-MinesInLine+1
    end
    ::point2::
    
    t = CopyButtons()
    local flag = 0
    for i = MinesInLine+1,MinesInLine^2-MinesInLine,MinesInLine do
      flag = 0
      for j=i+1, i+MinesInLine-1 do
        if t[i].text ~= '' then flag =1; end
    end
    if flag == 0 then t[i].text = char return i end
  end 

 t = CopyButtons()
for i=1,MinesInLine^2 do
  if t[i].text == '' then t[i].text = char return i end
end
end
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
    love.graphics.setFont(love.graphics.newFont(68))
    if gamemode == 'P vs P' then
      DrawWinMessage()
      if CellsOpend() % 2 == 0 then love.graphics.print('Player X turn')
      else
      love.graphics.print('Player O turn')
      end
    end
    if gamemode == 'P vs C' then
      DrawWinMessage()
      if Player == 'X' and CellsOpend() % 2 == 0 then love.graphics.print('Player X turn') end
      if Player == 'O' and CellsOpend() % 2 == 1 then love.graphics.print('Player O turn') end
      CompAI(Computer,Turn(),Player)
    end
    if gamemode == 'C vs C' then
      if CellsOpend() == MinesInLine^2 then
        love.graphics.setColor(0.8,0.8,0.8)
        love.graphics.print('Draw',210,300) 
        love.graphics.setColor(0.01,1,0.12)
        end
      if CellsOpend() ~= MinesInLine^2 then
      CompAI(Computer,Turn(),Player)
      love.timer.sleep(1)
      CompAI(Player,Turn(),Computer)
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
  if gamestate == 0 then 
    mainmenu:update()
    end
  if gamestate == 1 then winCheck,winPlayer = winChecker()  end
  if gamestate == 2 then settingsmenu:update() end
  end

function love.mousepressed( x, y, button, istouch )
  if button==1 and gamestate ==1 then updateButtons(x,y)
    if gamemode == 'P vs P' then end
    if gamemode == 'P vs C' then end
  end
end

function love.mousemoved(x, y, dx, dy, istouch)
    menuengine.mousemoved(x, y)
end

function love.keypressed(key, scancode, isrepeat)
    menuengine.keypressed(scancode)
    if scancode == 'escape' then gamestate = 0 end
    end