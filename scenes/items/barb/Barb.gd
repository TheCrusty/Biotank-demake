extends Node2D
var damage = 5

var itemName = "Barb"

var active = false
var tracksCursor = false

func activate():
	active = true
	var player = get_parent().get_parent()
	player.bump_damage = damage + player.bump_damage
