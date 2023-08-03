# Attack.gd
extends EnemyState

var AttackTimer

func ready():
	AttackTimer = enemy.get_node("AttackTimer")

func update(delta):
	super.update(delta)
	if(!enemy.inAttackRange):
		state_machine.transition_to("Seek")
	
func enter(_msg := {}):
	AttackTimer.start()

func exit():
	AttackTimer.stop()
