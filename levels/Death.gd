extends EnemyState

func enter(_msg := {}):
	enemy.get_node("CollisionShape").set_disabled(true)
