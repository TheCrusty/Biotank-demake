extends Node2D

@export var fireRate = 0.5

var active = false
var last_shot = 0

func _process(delta):
	if active and last_shot > fireRate:
		print("fire!")
		last_shot = 0
	last_shot += delta
		
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		active = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		active = false
