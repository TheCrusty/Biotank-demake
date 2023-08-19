# Attack.gd
extends EnemyState

var AttackTimer

func ready():
	AttackTimer = enemy.get_node("AttackTimer")

func enter(_msg := {}):
	AttackTimer.start()

func exit():
	AttackTimer.stop()
	enemy.get_node("AnimationPlayer").stop()

func handle_attack_range_body_exited(body):
	super.handle_attack_range_body_exited(body)
	state_machine.transition_to("Seek")
