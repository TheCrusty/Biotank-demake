# Death.gd
extends EnemyState

func ready():
	cant_leave = true

func enter(_msg := {}):
	enemy.emit_signal("enemy_death")
	enemy.get_node("CollisionShape").set_deferred("disabled", true)
	enemy.get_node("AttackRange").set_monitoring(false)
	enemy.get_node("VisionSphere").set_monitoring(false)
	enemy.get_node("Sprite2D").frame = 4

func handle_vision_sphere_area_entered(area):
	pass

func handle_vision_sphere_area_exited(area):
	pass

func handle_attack_range_body_entered(body):
	pass

func handle_attack_range_body_exited(body):
	pass

func takeDamage(damageAmount):
	pass
