class SceneMap

	def initialize
		@player = Player.new(128,128)
	end

	def update
		@player.update
		@player.move_left if $window.button_down?(KbLeft)
		@player.move_right if $window.button_down?(KbRight)
		@player.fall if no_ground?(@player.get_x, @player.get_y)
	end

	def draw
		@player.draw
	end

	def button_down(id)
		if id == KbUp then
			if !no_ground?(@player.get_x, @player.get_y) then
				@player.jump
			end
		end
	end

	def button_up(id)

	end

	def no_ground?(x, y)

		return y < 480

	end

end