function clearButtons()
  buttons = {}
  end

function CellsOpend()
  local cellsopendcount = 0
  for i,j in pairs(buttons) do
    if j.text ~= '' then  cellsopendcount=cellsopendcount+1 end
  end
  return cellsopendcount
  end

function PlaceSymbol(x,y)
  print(x,y,ButtonPlace(x,y),CellsOpend())
  if buttons[ButtonPlace(x,y)].text == '' then
  if CellsOpend() % 2 == 1 then buttons[ButtonPlace(x,y)].text = 'X'
  else buttons[ButtonPlace(x,y)].text = 'O' end
  if cells[ButtonPlace(x,y)] ==nil then cells[ButtonPlace(x,y)] = buttons[ButtonPlace(x,y)].text end end
end

function createCells()
  buttons = {}
  cells = {}
  size = w/MinesInLine
  for x = 0,w-1,size do
  for y = h-w,h-1,size do
  button:new(PlaceSymbol,'' ,x, y, 0, 0, {1,0.64,0}, love.graphics.newFont(size/5), {1,1,0},size-1,size-1) 
end end
  button:new(createCells,'Restart',450,0,0,0, {1,1,0},love.graphics.newFont(w/20),{1,0.84,0.13},150,50,472,8)
end

function ButtonPlace(x,y)
  local ans = 1
  for i = 0,w-1,size do
  for j = h-w,h-1,size do
    if x == i and y == j then return ans end
    ans = ans+1
  end end
  return nil
end