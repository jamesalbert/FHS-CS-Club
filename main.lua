require("AnAL")
hoc = require 'hoc'

--level 1

detect = hoc(100, player_collide, player_dismiss)
move = 0

function big_bang(self, filename)
	self = {
		x     = -16,
		y     = -16,
		image = love.graphics.newImage(filename),
		update_world = function (image, x, y)
			love.graphics.draw(image, x, y)
		end
	}
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()
	return self
end

function init_player(self, filename)
	self = {
		x       = 50,
		y       = 500,
		w       = 38,
		h       = 38,
		speed   = 0,
		image   = {
			sprite  = love.graphics.newImage(filename)
--			change_to = function (frame)
--				if frame == 'default' then
--					love.graphics.drawq(self.image.sprite, self.image.default, 200+self.speed, 385)
--				elseif frame == 'back' then
--					love.graphics.drawq(self.image.sprite, self.image.back, 200+self.speed, 385)
--				end
--			end
		},
		collision = {},
		update_player = function (image, x, y)
			love.graphics.draw(image, x, y)
		end
	}
	self.image.default = love.graphics.newQuad( 76, 38, self.w, self.h, 419, 270 )
	self.image.back = love.graphics.newQuad( 190, 228, self.w, self.h, 419, 270 )
	self.animation = newAnimation(self.image.sprite, 38, 38, 0.1, 6)
	self.collision.form = detect:addRectangle(
		self.x, self.y, self.w, self.h
	)
	self.image.change_to = function (frame)
        if frame == 'default' then
            love.graphics.drawq(self.image.sprite, self.image.default, 200+self.speed, 385)
        elseif frame == 'back' then
            love.graphics.drawq(self.image.sprite, self.image.back, 200+self.speed, 385)
        end 
    end
	return self
end

function world_object(self, filename)
	self = {
		x     = 200,
		y     = 500,
		image = self.image.newImage(filename)
	}
	self.w = self.image:getWidth()
    self.h = self.image:getHeight()
	self.collision.form = detect:addRectangle(
		self.x, self.y, self.w, self.h
	)
	return self
end

function player_collide()
end

function player_dismiss()
end

function get_key()
	if move < 1 and move > -2020 then
		if love.keyboard.isDown('a') then
			player.image.change_to('back')
			move = move + 2
			player.speed = player.speed - 2
		else
			player.image.change_to('default')
			move = move - 2
            player.speed = player.speed + 2
		end
	elseif move >= 1 then
		move = 0
		player.speed = 0
	elseif move <= -2020 then
		--move = move + 2
		--player.speed = player.speed - 2
	end
end

--------------------------------------------------

function love.load()
	world  = big_bang(world, 'world.png')
	player = init_player(player, 'player.png')
	--enemy  = world_objects('enemy.png')
end

function love.keypressed(key)
end

function love.keyreleased(key)
end

function love.update(dt)
	--get_key()
	player.animation:update(dt)
end

function love.draw()
	--get_key() wrong placement

	love.graphics.translate(move,0)
	world.update_world(world.image, world.x, world.y)
	--player.animation:draw(200, 200)
	--love.graphics.drawq(player.image.sprite, player.image.default, 200+player.speed, 385)
	get_key()
	love.graphics.print(move, 50 - move, 50)
end
