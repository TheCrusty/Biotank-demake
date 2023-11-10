extends Node2D

var active = false

func _ready():
	if randi() % 2 == 0:
		$TextureRect.texture = load("res://resources/barb.png")
	else:
		$TextureRect.texture = load("res://resources/cannon_sprite.png")

func activate():
	active = true

func _process(delta):
	if active:
		print("I am now active!")
