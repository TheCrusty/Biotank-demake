extends Node2D

var itemName = "Laser"

var active = false
var tracksCursor = true
var projectile = preload("res://scenes/projectiles/bullet/projectile.tscn")

func activate():
	active = true

func shoot():
	$AudioStreamPlayer2D.play()
	var projectile_instance = projectile.instantiate()
	projectile_instance.shooter = self
	get_tree().get_root().add_child(projectile_instance)
	projectile_instance.onFired(self.global_transform)
