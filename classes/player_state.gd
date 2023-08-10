class_name PlayerState
extends State

var player: Player


func _ready():
	# waits for owner to ready first
	await owner.ready
	# sets enemy variable to point to the owner if it is the Enemy type
	player = owner as Player
	# will fail if owner is not an Enemy as it will be null
	assert(player != null)
	ready()
	
# extra ready function to override, needed to stop buggy override of _ready
func ready():
	pass
	
func takeDamage(damageAmount):
	player.current_kill_combo_count -= 1
	player.current_health -= damageAmount
