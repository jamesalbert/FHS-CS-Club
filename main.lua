require("AnAL")
hoc = require 'hoc'

--level 1

detect = hoc(100, player_collide, player_dismiss)
move = 0
jump = 0
jump_on = 0
jump_off = 1

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
		jump    = 0,
		image   = {
			sprite  = love.graphics.newImage(filename)
		},
		collision = {},
		update_player = function (image, x, y)
			love.graphics.draw(image, x, y)
		end
	}
	self.image.width = self.image.sprite:getWidth()
	self.image.height = self.image.sprite:getHeight()
	self.image.default = love.graphics.newQuad( 76, 38, self.w, self.h, self.image.width, self.image.height )
	self.image.back = love.graphics.newQuad( 190, 228, self.w, self.h, self.image.width, self.image.height )
	self.image.jump = love.graphics.newQuad( 38, 38, self.w, self.h, self.image.width, self.image.height ) 
	self.animation = newAnimation(self.image.sprite, 38, 38, 0.1, 6)
	self.collision.form = detect:addRectangle(
		self.x, self.y, self.w, self.h
	)
	self.image.change_to = function (frame)
		new_x = 200+self.speed
		new_y = 385+jump
        if frame == 'default' then
            love.graphics.drawq(self.image.sprite, self.image.default, new_x, new_y)
        elseif frame == 'back' then
            love.graphics.drawq(self.image.sprite, self.image.back, new_x, new_y)
		elseif frame == 'jump' then
			love.graphics.drawq(self.image.sprite, self.image.jump, new_x, new_y)
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
	move = move - 2
	player.speed = player.speed + 2
	if move < 1 and move > -2020 then
		if love.keyboard.isDown('a') then
			player.image.change_to('back')
			move = move + 2
			player.speed = player.speed - 2
		elseif love.keyboard.isDown(' ') then
			player.image.change_to('jump')
			if jump > -36 and jump_off == -1 then
				jump = jump - 4
				jump_on = 1
			end
			if jump == -36 then
				jump_off = 1
				jump_on = 0
			end	
			if jump ~= 0 and jump_on == 0 then
                jump = jump + 2
				if jump == 0 then
					jump_off = 1
				end
            end
			if jump == 0 then
				--jump_off = 0
			end
		else
			player.image.change_to('default')
		end
	elseif move >= 1 then
		move = 0
		player.speed = 0
	elseif move <= -2020 then
		--move = move + 2

		--player.speed = player.speed - 2
	end
	if jump ~= 0 then
    	jump = jump + 2
	end
end

--------------------------------------------------

function love.load()
	world  = big_bang(world, 'world.png')
	player = init_player(player, 'player.png')
	--enemy  = world_objects('enemy.png')
end

function love.keypressed(key)
	if key == ' ' then
		jump_off = jump_off * -1
	end
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
