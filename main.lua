hoc = require "hoc"

move = 1
new_var = 3

function player_off()
	move = 0
end
	
function create_player(self,filename,x,y)
	self = {
		placement = {
			x     = x,
			y     = y
		},
		image = {
			body = love.graphics.newImage(filename),
		},
		collide = {
			detect = hoc(100, player_collide)
		}
	}
	self.width  = self.image.body:getWidth()
	self.height = self.image.body:getHeight()
	self.form   = self.collide.detect:addRectangle(
		self.placement.x,
		self.placement.y,
		self.width,
		self.height
	)
	return self
end

function player_collide()
    move = move * -1
end

function love.load()
	player  = create_player(player, 'largeVLC.png', 10, 10)
	collide = player.collide.detect
	
	force   = collide:addRectangle(500, 0, 100, 700)
end

function love.update(dt)
	player.placement.x = player.placement.x + move
	player.form:move(move,0)
	collide:update(dt)
end

function love.keypressed(key)
	if key == ' ' then
		move = move * -1
	end
end

function love.draw()
	love.graphics.draw(
		player.image.body,
		player.placement.x,
		player.placement.y
	)
	force:draw('line')
	player.form:draw('line')
end
