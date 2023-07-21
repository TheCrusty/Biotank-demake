extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Player = get_parent().get_parent().get_node("Player")
	$ProgressBar.set_value((Player.current_boost_amount / Player.total_boost_amount) * 100)
