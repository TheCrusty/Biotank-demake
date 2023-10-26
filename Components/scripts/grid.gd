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
	$Area2D/CollisionShape2D.shape.size.x = width * 60
	$Area2D/CollisionShape2D.shape.size.y = height * 60
	$Area2D.position.x = width * 30
	$Area2D.position.y = height * 30

func findNearestTile(position):
	pass


func _on_area_2d_body_entered(body):
	if(body.name == "TestItem"):
		body.overGrid = owner


func _on_area_2d_body_exited(body):
	if(body.name == "TestItem"):
		body.overGrid = null
