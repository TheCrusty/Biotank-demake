# Death.gd
extends EnemyState

func enter(_msg := {}):
	enemy.get_node("CollisionShape").set_deferred("disabled", true)
	enemy.get_node("AttackRange").set_monitoring(false)
	enemy.get_node("VisionSphere").set_monitoring(false)
	enemy.get_node("Sprite2D").frame = 4
