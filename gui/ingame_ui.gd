extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Player = get_parent().get_parent().get_node("Player")
	$BoostBar.set_value((Player.current_boost_amount / Player.total_boost_amount) * 100)
	$BloodLustBar.set_value((Player.current_kill_combo_count / Player.max_kill_combo_count) * 100)
	$HealthBar.set_value((Player.current_health / Player.max_health) * 100)
