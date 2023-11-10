extends Node2D
var damage = 5
var active = false

func _ready():
	$TextureRect.texture = load("res://resources/barb.png")

func activate():
	active = true
	var player = get_parent().get_parent()
	player.bump_damage = damage + player.bump_damage
