function randomPlayer()
      local Player = love.math.random(2)
      local Computer
      if Player == 1 then Player = 'X'; Computer = 'O'
      else Computer = 'X'; Player = 'O' end
      return Player,Computer
  end

function clearButtons() -- clear buttons
  buttons = {}
  end

function CellsOpend()  -- count numbers opend cells
  local cellsopendcount = 0
  for i = 1,MinesInLine^2  do
    j = buttons[i]
    if j.text ~= '' then  cellsopendcount=cellsopendcount+1 end
  end
  return cellsopendcount
  end

function PlaceSymbol(x,y) -- place symbol on button
  if buttons[ButtonPlace(x,y)].text == '' and not winCheck then
  if CellsOpend() % 2 == 0 then buttons[ButtonPlace(x,y)].text = 'X'
  else buttons[ButtonPlace(x,y)].text = 'O' end
  if cells[ButtonPlace(x,y)] ==nil then cells[ButtonPlace(x,y)] = buttons[ButtonPlace(x,y)].text end end
  --print(x,y,ButtonPlace(x,y),CellsOpend())
end

function createCells() -- create new area of cells
  buttons = {}
  cells = {}
  size = w/MinesInLine
  if gamemode == 'P vs C' then Player,Computer = randomPlayer() end
  for x = 0,w-1,size do
  for y = h-w,h-1,size do
  button:new(PlaceSymbol,'' ,x, y, 0, 0, {1,0.64,0}, love.graphics.newFont(size/3), {1,1,0},size-1,size-1,x+(size/3),y+(size/3)) 
end end
  button:new(createCells,'Restart',450,0,0,0, {1,1,0},love.graphics.newFont(w/20),{1,0.84,0.13},150,50,472,8)
end

function ButtonPlace(x,y)  -- find place of button by x and y coord
  local ans = 1
  for i = 0,w-1,size do
  for j = h-w,h-1,size do
    if x == i and y == j then return ans end
    ans = ans+1
  end end
  return nil
end


local function checkAllElem(t)  -- function for winChecker()
  if t[1] ~= '' then
  for i = 1,#t-1 do
    for j = i+1,#t do
      if t[i]~=t[j] then return false end
    end
  end
  return true
  end
  end

function winChecker(tbl) -- function who check win, true = win , false = ?
  b = tbl or buttons
  for j = 1,MinesInLine^2,MinesInLine do
    local t = {}
    local k = 1
  for i = j,j+MinesInLine-1 do
    t[k] = b[i].text
    k = k+1
  end
  if checkAllElem(t) then return true,t[1] end
end

for j = 1, MinesInLine do
  local t = {}
  local k = 1
for i = j, MinesInLine^2-MinesInLine+j,MinesInLine do
  t[k] = b[i].text
    k = k+1
  end
  if checkAllElem(t) then return true,t[1] end
    end
    
local t = {}
local k = 1
 for i = MinesInLine,MinesInLine^2-MinesInLine+1,MinesInLine-1 do
   t[k] = b[i].text
    k = k+1
    end
 if checkAllElem(t) then return true,t[1] end
 
t = {}
k = 1
 for i = MinesInLine^2,1,-MinesInLine-1 do
   t[k] = b[i].text
    k = k+1
    end
 if checkAllElem(t) then return true,t[1] end 
 
return false
end