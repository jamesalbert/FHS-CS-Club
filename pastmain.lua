hoc = require "hoc"

--When we set up a collision detector,
--there is one function that is called
--when the collision begins, and another
--that is called once the collision ends.

--This one is called when the collision begins.

function player_collide()
	--player.placement.x = player.old.x
	--player.placement.y = player.old.y
end

--This one is called when the collision ends.

function player_off()	
end
	
--This function, like any other, can be
--called as many times as possible; therefore,
--we can use it to create players the user
--control and enemies, bosses, etc that the
--user can not control. This function is
--used in this format:
	--	player = create_player(player, '/directory/to/file.png', 10, 10)
--This constructs an object from the variable player. Player is now an
--object, or as they call it in Lua, a table.

function create_player(self,filename,x,y)
	self = {
		placement = {
			x     = x,
			y     = y
		},
		old = {
			x = 0,
			y = 0
		},
		move = {
			x    = 0,
			y    = 0,
			spin = 0
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

function x_stop()
	player.move.x = 0
end

function y_stop()
	player.move.y = 0
end

--All of these functions get called when the code gets ran.

--This function only gets called once, at run time.

function love.load()
	player  = create_player(player, 'sean.png', 100, 100)
	collide = player.collide.detect
	
	force   = collide:addRectangle(500, 0, 100, 700)
end

--This function gets called when a key is pressed.

function love.keypressed(key)
    if key == 'd' then
		y_stop()
        player.move.x = 4
    elseif key == 'a' then
		y_stop()
		player.move.x = -4
	elseif key == 'w' then
		x_stop()
		player.move.y = -4
	elseif key == 's' then
		x_stop()
		player.move.y = 4
	end
end

--The next two functions are called over and
--over again (around once every .335 ms) until
--the program is stopped.

function love.update(dt)
	player.placement.x = player.placement.x + player.move.x
	player.placement.y = player.placement.y + player.move.y
	player.move.spin = player.move.spin + dt
	player.form:move(player.move.x,player.move.y)
	collide:update(dt)
end

function love.draw()
	love.graphics.draw(
		player.image.body,
		player.placement.x,
		player.placement.y,
		player.move.spin,
		1, 1,
		player.width - player.width/2,
		player.height - player.height/2
	)
	love.graphics.circle(
		'fill',
		love.graphics.getWidth()/2,
		love.graphics.getHeight()/2,
		50,
		360
	)
	force:draw('line')
	player.form:draw('line')
end
