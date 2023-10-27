extends Node2D

var dragging = false
var overGrid = null
var lastPosition

func _process(delta):
	if dragging:
		owner.global_position = get_global_mouse_position()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if dragging:
			dragging = false
			if(overGrid == null):
				owner.global_position = lastPosition
				print("I don't believe it")
			else:
				#if(overGrid.has_method("findNearestTile")):
				owner.global_position = overGrid.findNearestTile(owner.global_position)
				lastPosition = owner.global_position
		else:
			dragging = true
			lastPosition = owner.global_position
