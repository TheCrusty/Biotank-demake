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
			else:
				if(overGrid.has_method("findNearestTile")):
					position = overGrid.findNearestTile(position)
					lastPosition = null
		else:
			dragging = true
			lastPosition = position
