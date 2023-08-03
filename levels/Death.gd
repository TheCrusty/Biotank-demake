extends EnemyState

func enter(_msg := {}):
	#enemy.get_node("CollisionShape").set_disabled(true)
	enemy.get_node("AttackRange").set_monitoring(false)
	enemy.get_node("Sprite2D").frame = 4

func update(delta):
	enemy.get_node("CollisionShape").set_disabled(true)
	super.update(delta)
