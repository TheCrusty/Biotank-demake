extends Node2D

@export var canDrag = true
@export var collisionWidth = 60
@export var collisionHeight = 60
var dragging = false
var overGrid = null
var lastPosition

func _ready():
	$Area2D/CollisionShape2D.shape.size.x = collisionWidth
	$Area2D/CollisionShape2D.shape.size.y = collisionHeight
	$Area2D/CollisionShape2D.position.x = 0
	$Area2D/CollisionShape2D.position.y = 0


func _process(delta):
	if dragging:
		owner.global_position = get_global_mouse_position()


func _on_area_2d_input_event(viewport, event, shape_idx):
	print(1)
	if event is InputEventMouseButton and event.pressed:
		print(5)
		if dragging:
			dragging = false
			print(2)
			if(overGrid == null):
				owner.global_position = lastPosition
			else:
				print(3)
				#if(overGrid.has_method("findNearestTile")):
				owner.global_position = overGrid.findNearestTile(owner.global_position)
				lastPosition = owner.global_position
		else:
			print(4)
			dragging = true
			lastPosition = owner.global_position
