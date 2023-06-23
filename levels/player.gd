extends CharacterBody2D

@export var max_speed = 14450.0
@export var damper = 0.015
@export var rotation_speed = 3

var engine_power = 800
var boost_power = 400
var current_boost = 0
var acceleration = Vector2.ZERO
var friction = -2
var projectile = preload("res://levels/projectile.tscn")
var rotation_direction = 0


func _on_ready():	
	$BoostParticles.emitting = false
	
func get_input():
	if Input.is_action_pressed("Boost"):
		current_boost = boost_power
		$BoostParticles.emitting = true
	else:
		current_boost = 0
		$BoostParticles.emitting = false
		
	if Input.is_action_just_pressed("Shoot"):
		var projectile_instance = projectile.instantiate()
		projectile_instance.shooter = self
		owner.add_child(projectile_instance)
		projectile_instance.transform = $TankTopPivot.global_transform
	else:
		rotation_direction = Input.get_axis("Rotate_Left", "Rotate_Right")
		if Input.is_action_pressed("Forward") or Input.is_action_pressed("Reverse"):
			acceleration = transform.x * (engine_power + current_boost) * Input.get_axis("Forward", "Reverse")

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	velocity += acceleration * delta
	rotation += rotation_direction * rotation_speed * delta
	$TankTopPivot.look_at(get_global_mouse_position())
	move_and_slide()
	
func apply_friction():
	#fully stops at low speeds
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	if velocity.length() < 100:
		friction_force *= 3
	acceleration += friction_force
