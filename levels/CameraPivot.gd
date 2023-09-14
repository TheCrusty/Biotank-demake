extends Node2D

func _process(delta):
	var mousePos = get_global_mouse_position()
	position.x = (owner.x + mousePos.x ) / 2
	position.y = (owner.y + mousePos.y ) / 2
