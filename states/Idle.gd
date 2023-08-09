# Idle.gd
extends EnemyState

func handle_vision_sphere_area_entered(area):
	super.handle_vision_sphere_area_entered(area)
	state_machine.transition_to("Seek")
