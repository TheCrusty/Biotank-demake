# Idle.gd
extends EnemyState


func update(delta):
	super.update(delta)
	if enemy.playerInSight:
		state_machine.transition_to("Seek")
