extends Node2D

var dragging = false


func _process(delta):
	if dragging:
		owner.position = get_global_mouse_position()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("clicked!")
		if dragging:
			dragging = false
		else:
			dragging = true
