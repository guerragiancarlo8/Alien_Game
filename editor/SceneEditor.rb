class SceneEditor

	def initialize
		@bg = Image.new("editor/editor.png",{:tileable => false})
		@sel_16 = Image.new("editor/sel16.png",{:tileable => false})
		@sel_16_x = 16
		@sel_16_y = 112
		@selected_tile = 0
		@current_layer = 0
		@grid  = Image.new("editor/grid.png",{:tileable => false})



		@offset_x = 0
		@offset_y = 0
		@ctrl_held = false


		width = 60
		height = 45
		@level = []
		for layer in 0...2
			@level[layer] = []
			for y in 0...height
				@level[layer][y] = []
				for x in 0...width
					@level[layer][y][x] = 0
				end
			end
		end

		@tileset = Image.load_tiles("graphics/tiles/area02_level_tiles.png",16,16,{:tileable=>true})
	end

	def update
		if $window.button_down?(MsLeft) and $window.mouse_x.between?(368,1008) and $window.mouse_y.between?(160,640) then
			place_tile($window.mouse_x,$window.mouse_y)
		end

	end

	def draw
		@bg.draw(0,0,0)

		for l in 0...@level.size
			for y in 0...@level[l].size
				for x in 0...@level[l][y].size
					if x < 40 and y < 30 then
						tx = 368 + (x*16)
						ty = 160 + (y*16)
						i = @level[l][y + @offset_y][x + @offset_x]
						@tileset[i].draw(tx,ty,1+l) if i!=0 and i!=nil
					end
				end
			end
		end

		for i in 0...@tileset.size
			tx = 16 + ((i%20)*16)
			ty = 112 +((i/20)*16)
			@tileset[i].draw(tx,ty,1)
		end

		@sel_16.draw(@sel_16_x,@sel_16_y,5)
	end

	def select_tile(x,y)
		tx = ((x-16)/16).floor
		ty = ((y-112)/16).floor
		i = tx + (ty*20)
		@sel_16_x = (tx*16) + 16
		@sel_16_y = (ty*16) + 112
		@selected_title = i
	end

	def place_tile(x,y)
		tx = ((x-368)/16).floor
		ty = ((y-160)/16).floor
		@level[@current_layer][ty][tx] = @selected_tile

	end

	def click
		if $window.mouse_x.between?(16,336) and $window.mouse_y.between?(112,304) then
			select_tile($window.mouse_x, $window.mouse_y)
		elsif $window.mouse_x.between?(368,1008) and $window.mouse_y.between?(160,640) then
			place_tile($window.mouse_x, $window.mouse_y)
		end
	end

	def increase_offset(forced=false)
		if @ctrl_held or forced then
			@offset_x += 1 if(@offset_x < @level[0][0].size - 40)
		else
			@offset_y += 1 
		end
	end

	def decrease_offset(forced=false)
		if @ctrl_held or forced then
			@offset_x -= 1 if @offset_x != 0
		else
			@offset_y -= 1 if @offset_x != 0
		end
	end

	def button_down(id)
		if id == MsLeft then
			click
		end

		if id == MsWheelDown then
			increase_offset
		end

		if id == MsWheelUp then
			decrease_offset
		end

		if id == KbLeftControl then 
			@ctrl_held = true
		end

		if id == KbUp then
			decrease_offset
		end

		if id == KbDown then
			increase_offset
		end

		if id == KbLeft then 
			decrease_offset(true)
		end

		if id == KbRight then
			increase_offset(true)
		end
	end

	def button_up(id)
		if id == KbLeftControl then 
			@ctrl_held = false
		end
	end

end