extends Node2D

@export var fireRate = 0.5

var active = false
var last_shot = 0
var health = 10

var target

var projectile = preload("res://enemy/enemy_projectile.tscn")

func _process(delta):
	if active:
		pass

func takeDamage(damageAmount):
	health -= damageAmount
	if(health <= 0):
		queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		target = body
		active = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		target = null
		active = false
