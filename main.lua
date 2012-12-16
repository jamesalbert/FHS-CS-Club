hoc = require "hoc"

--This variable will be used later.
move = 1

--When we set up a collision detector,
--there is one function that is called
--when the collision begins, and another
--that is called once the collision ends.

--This one is called when the collision begins.

function player_collide()
    move = move * -1
end

--This one is called when the collision ends.

function player_off()
	player = nil
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

--All of these functions get called when the code gets ran.

--This function only gets called once, at run time.

function love.load()
	player  = create_player(player, 'largeVLC.png', 10, 10)
	collide = player.collide.detect
	
	force   = collide:addRectangle(500, 0, 100, 700)
end

--This function gets called when a key is pressed.

function love.keypressed(key)
    if key == 'd'
	and move ~= 1 then
        move = move * -1 
	elseif key == 'a'
	and move ~= -1 then
		move = move * -1
	end
end

--The next two functions are called over and
--over again (around once every .335 ms) until
--the program is stopped.

function love.update(dt)
	player.placement.x = player.placement.x + move
	player.form:move(move,0)
	collide:update(dt)
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
