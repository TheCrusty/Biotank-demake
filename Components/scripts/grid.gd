extends Control

@export var height = 4
@export var width = 6
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
			currentBox.set_mouse_filter(Control.MOUSE_FILTER_PASS)
			self.add_child(currentBox)
			index.append(currentBox)
	$Area2D/CollisionShape2D.shape.size.x = width * 60
	$Area2D/CollisionShape2D.shape.size.y = height * 60
	$Area2D.position.x = width * 30
	$Area2D.position.y = height * 30
	

func findNearestTile(itemPosition):
	var smallestDistance = 10000000
	var winningTilePosition = null
	for currentTile in index:
		var currentTilePosition = currentTile.global_position
		currentTilePosition.x += 25
		currentTilePosition.y += 25
		if currentTilePosition.distance_to(itemPosition) <= smallestDistance:
			smallestDistance = currentTilePosition.distance_to(itemPosition)
			winningTilePosition = currentTilePosition
	return winningTilePosition

func _on_area_2d_area_entered(area):
	print("am I make it?")
	if(area.owner.name == "Draggable"):
		area.owner.overGrid = self

func _on_area_2d_area_exited(area):
	if(area.owner.name == "Draggable"):
		area.owner.overGrid = null
