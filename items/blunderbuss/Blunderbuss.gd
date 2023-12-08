extends Node2D

var itemName = "Cannon"

var active = false
var tracksCursor = true
var projectile = preload("res://levels/projectile.tscn")

func activate():
	active = true

func shoot():
	var projectile_instance = projectile.instantiate()
	var projectile_instance_left = projectile.instantiate()
	var projectile_instance_right = projectile.instantiate()
	projectile_instance.shooter = self
	
	get_tree().get_root().add_child(projectile_instance)
	get_tree().get_root().add_child(projectile_instance_left)
	get_tree().get_root().add_child(projectile_instance_right)
	
	projectile_instance.onFired(self.global_transform)
	#0.523599 is 30 degrees in radians
	projectile_instance_left.onFired(self.global_transform.rotated_local(-0.523599))
	projectile_instance_right.onFired(self.global_transform.rotated_local(0.523599))
