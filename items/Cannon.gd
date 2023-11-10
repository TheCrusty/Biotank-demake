extends Node2D

var active = false
var tracksCursor = true
var projectile = preload("res://levels/projectile.tscn")

func _ready():
	$TextureRect.texture = load("res://resources/cannon_sprite.png")

func activate():
	active = true

func shoot():
	var projectile_instance = projectile.instantiate()
	projectile_instance.shooter = self
	get_tree().get_root().add_child(projectile_instance)
	projectile_instance.onFired(self.global_transform)
