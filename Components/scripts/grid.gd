extends Control

@export var height = 4
@export var width = 4
var index = []

func _ready():
	for i in height:
		for j in width:
			var currentBox = ColorRect.new()
			currentBox.set_color(Color(255, 225, 100))
			currentBox.size.x = 50
			currentBox.size.y = 50
			currentBox.position.y = (60 * i)
			currentBox.position.x = (60 * j)
			self.add_child(currentBox)
			index.append(currentBox)
