class SceneMap

	def initialize
		file = File.open("data/Map001.map")
		@used_tileset = Marshal.load(file)
		@tileset = Image.load_tiles("graphics/tiles/#{@used_tileset}",16,16,{:tileable => true})
		@level = Marshal.load(file)
		@objects = Marshal.load(file)
		file.close
		
		@player = nil
		@entities = []
		load_entities

		@camera_x = 0
		@camera_y = 0

		
	end

	def load_entities
		for i in 0...@objects.size
			case @objects[i][0]
			when :player
				@player = Player.new(@objects[i][1],@objects[i][2])
			end
		end
	end

	def wall?(x,y,direction)

		tile_x = (x/16).to_i
		tile_y = (y/16).to_i
		if direction == :left then
			return @level[0][tile_y-1][tile_x-1] == 0
		elsif direction == :right then
			return @level[0][tile_y-1][tile_x+1] == 0
		end
	end

	def update

		if $window.button_down?(KbLeft) && wall?(@player.get_x, @player.get_y,:left) then
			@player.move_left
		end

		if $window.button_down?(KbRight) && wall?(@player.get_x,@player.get_y,:right) then
			@player.move_right
		end
		@player.update
		@player.fall if no_ground?(@player.get_x, @player.get_y)
		if @player.is_jumping? then
			if solid_overhead?(@player.get_x,@player.get_y) then
				@player.reset_jump
			end
		end

		@camera_x = [[@player.get_x - 320,0].max,@level[0][0].size*16 - 640].min
		@camera_y = [[@player.get_y - 240,0].max,@level[0].size * 16 -480].min

	end

	def solid_overhead?(x,y)
		tile_x = (x/16).to_i
		tile_y = (y/16).to_i

		return @level[0][tile_y-2][tile_x]!= 0
	end

	def draw
		@player.draw(@camera_x, @camera_y)
		for l in 0...@level.size
			for y in 0...@level[l].size
				for x in 0...@level[l][y].size
					@tileset[@level[l][y][x]].draw((x*16) - @camera_x,(y*16) - @camera_y,1)
				end
			end
		end
	end

	def button_down(id)
		if id == KbUp then
			if !no_ground?(@player.get_x, @player.get_y) then
				@player.jump
			end
		end
	end

	def button_up(id)
		if id == KbUp then
			if @player.is_jumping?
				@player.reset_jump
			end
		end
	end

	def no_ground?(x, y)
		tile_x = (x/16).to_i
		tile_y = (y/16).to_i
		return @level[0][tile_y][tile_x] == 0
	end

end