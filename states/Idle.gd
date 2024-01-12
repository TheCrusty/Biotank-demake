# Idle.gd
extends EnemyState

@export var visionEnteredState : State

var visionEnteredTransition = "Seek"

func ready():
	super.ready()
	if(is_instance_valid(visionEnteredState)):
		visionEnteredTransition = visionEnteredState.stateName

func handle_vision_sphere_area_entered(area):
	super.handle_vision_sphere_area_entered(area)
	state_machine.transition_to(visionEnteredTransition)
