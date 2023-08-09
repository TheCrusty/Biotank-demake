class_name Player
extends CharacterBody2D

@export var max_speed = 14450.0
@export var damper = 0.015
@export var rotation_speed = 3
@export var boost_depletion_rate = 2000
@export var total_boost_amount = 3000
@export var bump_damage = 5
var current_boost_amount = 3000
var engine_power = 800
var boost_power = 400
var current_boost = 0
var acceleration = Vector2.ZERO
var friction = -2
var projectile = preload("res://levels/projectile.tscn")
var rotation_direction = 0
var max_zoom = 1.15
var boosting = false
var current_kill_combo_count = 0.0
var max_kill_combo_count = 5.0
signal enemy_death

func _enemy_death_handler():
	if $BloodLustTimer.is_stopped():
		if current_kill_combo_count < max_kill_combo_count:
			current_kill_combo_count += 1.0
		else:
			$StateMachine.transition_to("invincible")
			$BloodLustTimer.start()

func _on_ready():
	$BoostParticles.emitting = false

func get_input(delta):
	if Input.is_action_pressed("Boost") and current_boost_amount > 0:
		current_boost = boost_power
		boosting = true
		current_boost_amount -= (boost_depletion_rate/2) * delta
		$BoostParticles.emitting = true
		#if $Camera2D.zoom.y < max_zoom:
			#$Camera2D.zoom.y += 0.008
			#$Camera2D.zoom.x += 0.008
	else:
		boosting = false
		if current_boost_amount < total_boost_amount:
			current_boost_amount += (boost_depletion_rate/4) * delta
		current_boost = 0
		$BoostParticles.emitting = false
		#$Camera2D.zoom.y = 1
		#$Camera2D.zoom.x = 1
	$TankBottomPivot/TankBottom.set_modulate(Color(1, current_boost_amount/total_boost_amount, current_boost_amount/total_boost_amount, 1))

	if Input.is_action_just_pressed("Shoot"):
		var projectile_instance = projectile.instantiate()
		projectile_instance.shooter = self
		owner.add_child(projectile_instance)
		projectile_instance.onFired($TankTopPivot.global_transform)
	else:
		rotation_direction = Input.get_axis("Rotate_Left", "Rotate_Right")
		if Input.is_action_pressed("Forward") or Input.is_action_pressed("Reverse"):
			acceleration = transform.x * (engine_power + current_boost) * Input.get_axis("Forward", "Reverse")


func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input(delta)
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
	
func take_damage(damageAmount):
	$StateMachine.call_deferred("takeDamage", damageAmount)

func _on_bump_zone_body_entered(body):
	if boosting && body.has_method("takeDamage"):
		body.takeDamage(bump_damage)
		body.externalForce += velocity/2

func _on_blood_lust_timer_timeout():
	if current_kill_combo_count > 0:
		current_kill_combo_count -= 1
	else:
		$BloodLustTimer.stop()
		$StateMachine.transition_to("default")
	
