extends Node2D

func _ready():
	if randi() % 2 == 0:
		$TextureRect.texture = load("res://resources/placeholders/Iron Sword.png")
	else:
		$TextureRect.texture = load("res://resources/placeholders/Blue Jeans.png")
