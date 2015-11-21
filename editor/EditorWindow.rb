class EditorWindow < Gosu::Window

	def initialize
		super(1024,768,false)
		self.caption = "Buho Algaro: Editor de Mapa"
		$winow = self
		$scene = SceneEditor.new
	end

	def update
		$scene.update
	end

	def draw
		$scene.draw
	end

	def button_down(id)
		$scene.button_down(id)
	end

	def button_up(id)
		$scene.button_up(id)
	end

	def needs_cursor?
		return true
	end
end