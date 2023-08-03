extends EnemyState


func update(delta):
	enemy.seekMovement = Vector2.ZERO
	enemy.seekMovement = enemy.position.direction_to(enemy.target.position) * enemy.speed 
	enemy.look_at(enemy.target.position)
	super.update(delta)
	if(enemy.inAttackRange):
		state_machine.transition_to("Attack")
	elif(!enemy.playerInSight):
		state_machine.transition_to("Idle")

# sets seekmovement back to zero before leaving seek
func exit():
	enemy.seekMovement = Vector2.ZERO
