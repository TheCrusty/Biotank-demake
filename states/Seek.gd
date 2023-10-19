# Seek.gd
extends EnemyState


func update(delta):
	enemy.seekMovement = Vector2.ZERO
	enemy.seekMovement = enemy.position.direction_to(enemy.target.position) * enemy.speed 
	enemy.look_at(enemy.target.position)
	super.update(delta)

func enter(_msg := {}):
	owner.get_node("Alerted").play()

# sets seekmovement back to zero before leaving seek
func exit():
	enemy.seekMovement = Vector2.ZERO

func handle_vision_sphere_area_exited(area):
	super.handle_vision_sphere_area_exited(area)
	state_machine.transition_to("Idle")

func handle_attack_range_body_entered(body):
	super.handle_attack_range_body_entered(body)
	state_machine.transition_to("Attack")
