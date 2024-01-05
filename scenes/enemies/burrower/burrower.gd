extends Node2D

@export var fireRate = 0.5

var active = false
var last_shot = 0
var health = 10

var target

var projectile = preload("res://scenes/projectiles/spit/enemy_projectile.tscn")

func _process(delta):
	if active and last_shot > fireRate:
		$TargetFacer.look_at(target.position)
		var projectile_instance = projectile.instantiate()
		projectile_instance.shooter = self
		owner.add_child(projectile_instance)
		projectile_instance.onFired($TargetFacer.global_transform)
		last_shot = 0
	last_shot += delta
	
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
