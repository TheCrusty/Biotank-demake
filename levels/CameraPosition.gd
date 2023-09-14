extends RemoteTransform2D

func _process(delta):
	var mousePos = get_local_mouse_position()
	position.x = (owner.position.x + mousePos.x ) / 2
	position.y = (owner.position.y + mousePos.y ) / 2
