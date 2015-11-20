class GameWindow < Window

	def initialize
		super(640,480,false)
		self.caption = "Buho Algaro"
		$scene = SceneMap.new
		$window = self
	end

	def update
		$scene.update

	end

	def draw
		$scene.draw
		#window.draw_line(0,0,Color.new(255,255,255),640,480,Color.new(255,255,2550),0)

	end

	def button_down(id)
		$scene.button_down(id)

	end

	def button_up(id)
		$scene.button_up(id)
	end

end