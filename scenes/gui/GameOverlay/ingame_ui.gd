extends Node2D

var player

func _ready():
	await owner.ready
	
	# Ensures there is a Player node and that it is of type Player
	player = owner.get_node("Player") as Player
	assert(player != null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$BoostBar.set_value((player.current_boost_amount / player.total_boost_amount) * 100)
	$BloodLustBar.set_value((player.current_kill_combo_count / player.max_kill_combo_count) * 100)
	$HealthBar.set_value((player.current_health / player.max_health) * 100)
