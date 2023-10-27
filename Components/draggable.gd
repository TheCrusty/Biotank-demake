extends Node2D

var dragging = false
var overGrid = null
var lastPosition

func _process(delta):
	if dragging:
		owner.position = get_global_mouse_position()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if dragging:
			dragging = false
			if(overGrid == null):
				position = lastPosition
				print("I don't believe it")
			else:
				#if(overGrid.has_method("findNearestTile")):
				overGrid.findNearestTile(position)
				lastPosition = position
		else:
			dragging = true
			lastPosition = position
