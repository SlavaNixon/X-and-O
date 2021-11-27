local class = require("middleclass")
button = class("button")
buttons = {}
local originalFont = love.graphics.getFont()

function button:initialize(code, text, x, y, rx, ry, textColor, font, color,sizex,sizey,txtx,txty)

	self.code = code
	self.text = text
	self.x = x
	self.y = y
	self.rx = rx or 0
	self.ry = ry or 0
	self.textColor = textColor or {200,200,200}
	self.font = font or love.graphics.getFont()
	self.color = color or {150,150,150}
	self.originalColor = self.color 
  self.sizex = sizex
  self.sizey = sizey

  self.textx = txtx or self.x + self.sizex/2
  self.texty = txty or self.y +self.sizey/2

	self.id = #buttons + 1
	table.insert(buttons, self)
	return self
end

function button:update(x,y)
	if x == nil and y == nil then x, y = love.mouse.getX(), love.mouse.getY() end
	if x < self.x + self.sizex and x > self.x and y < self.y + self.sizey and y > self.y then 
		if love.mouse.isDown(1) then 
			self.code(self.x,self.y)
		end
		--self.color = {self.color[1] + 20, self.color[2] + 20, self.color[3] + 20}
	else
		self.color = self.originalColor
	end 
end

function button:draw()
	love.graphics.setFont(self.font)

	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill", self.x, self.y, self.sizex , self.sizey , self.rx, self.ry)

	love.graphics.setColor(self.textColor)
	love.graphics.print(self.text, self.textx, self.texty)
	
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(originalFont)
end 

function updateButtons()
	for i, v in pairs(buttons) do
		v:update(x,y)
	end
end

function drawButtons()
	for i, v in pairs(buttons) do
		v:draw()
	end 
end