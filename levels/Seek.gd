extends EnemyState


func update(delta):
	enemy.seekMovement = Vector2.ZERO
	enemy.seekMovement = enemy.position.direction_to(enemy.target.position) * enemy.speed 
	enemy.look_at(enemy.target.position)
	super.update(delta)

# sets seekmovement back to zero before leaving seek
func exit():
	enemy.seekMovement = Vector2.ZERO
