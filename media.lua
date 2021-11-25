function createImages()
local t = {}
t.back = love.graphics.newImage("photo/back.jpg")
for i=1,6 do
  t[i] = love.graphics.newImage("photo/"..i..'.jpg')
end
return t
end