move = 1

function create_player(self,filename,x,y)
	self = {
		placement = {
			x     = x,
			y     = y
		},
		image      = {
			body   = love.graphics.newImage(filename),
		}
	}
	width  = self.image.body:getWidth()
    height = self.image.body:getHeight()
	return self
end

function love.load()
	player = create_player(player, 'largeVLC.png', 10, 10)
end

function love.update(dt)
	player.placement.x = player.placement.x + move
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
end
