extends Node2D

var active = false

func _ready():
	$TextureRect.texture = load("res://resources/barb.png")

func activate():
	active = true

func _process(delta):
	if active:
		print("I am now active!")
