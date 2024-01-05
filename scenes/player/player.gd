class_name Player
extends CharacterBody2D

# Engine Properties
@export var boost_depletion_rate = 2000
@export var total_boost_amount = 3000
var current_boost_amount = 3000
var engine_power = 800
var boost_power = 400
var current_boost = 0
var boosting = false

# Physics Properties
@export var max_speed = 14450.0
@export var damper = 0.015
@export var rotation_speed = 3
var acceleration = Vector2.ZERO
var friction = -2
var rotation_direction = 0

# Game Properties
@export var bump_damage = 5
var current_kill_combo_count = 0.0
var max_kill_combo_count = 5.0
var current_health = 5.0
var max_health = 5.0

# Others
var projectile = preload("res://scenes/projectiles/bullet/projectile.tscn")
var death_scene = preload("res://scenes/gui/game_over_menu.tscn").instantiate()
var max_zoom = 1.15
var Camera = null


func _enemy_death_handler():
	if $BloodLustTimer.is_stopped():
		if current_kill_combo_count < max_kill_combo_count:
			current_kill_combo_count += 1.0
		else:
			$StateMachine.transition_to("invincible")
			$BloodLustTimer.start()

func _ready():
	$BoostParticles.emitting = false
	await owner.ready
	Camera = owner.get_node("Camera2D")
	EventBus.enemy_death.connect(_enemy_death_handler)
	#activate_items()
	loadItems()
	
func get_input(delta):
	if Input.is_action_pressed("Boost") and current_boost_amount > 0:
		if !$audioBoost.is_playing():
			$audioBoost.play()
		current_boost = boost_power
		boosting = true
		current_boost_amount -= (boost_depletion_rate/2) * delta
		$BoostParticles.emitting = true
		if Camera.zoom.y < max_zoom:
			Camera.zoom.y += 0.008
			Camera.zoom.x += 0.008
	else:
		boosting = false
		if current_boost_amount < total_boost_amount:
			current_boost_amount += (boost_depletion_rate/4) * delta
		current_boost = 0
		$BoostParticles.emitting = false
		Camera.zoom.y = 1
		Camera.zoom.x = 1
		$audioBoost.stop()
		
	$TankBottomPivot/TankBottom.set_modulate(Color(1, current_boost_amount/total_boost_amount, current_boost_amount/total_boost_amount, 1))

	if Input.is_action_just_pressed("Shoot"):
		var projectile_instance = projectile.instantiate()
		projectile_instance.shooter = self
		owner.add_child(projectile_instance)
		for panel in $ItemGridContainer.get_children():
			var panelChildren = panel.get_children()
			if panelChildren.size() > 0:
				if panelChildren[0].has_method("shoot"):
					panelChildren[0].shoot()
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
	for panel in $ItemGridContainer.get_children():
		var panelChildren = panel.get_children()
		if panelChildren.size() > 0:
			print(panelChildren[0])
			if panelChildren[0].tracksCursor:
				panelChildren[0].look_at(get_global_mouse_position())
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
	$audioDamaged.play()

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

func _on_bump_zone_area_entered(area):
	if area.owner.name == "DNA":
		PlayerVariables.dnaCount += area.owner.value
		area.owner.queue_free()
		area.owner.pickup()
		
func activate_items():
	for item in $ItemGridContainer.get_children():
		item.activate()
		
func loadItems():
	var nextPanel = 0
	for item in PlayerVariables.body:
		if item != "Empty":
			var scene = $ItemLoader.getItemScene(item)
			
			# Changing default rotation of sprite.
			var sprite = scene.get_node("TextureRect")
			#sprite.set_rotation_degrees(sprite.get_rotation_degrees()+90)
			
			# Assign item to the next avaliable panel and increment.
			var panels = $ItemGridContainer.get_children()
			panels[nextPanel].add_child(scene)
			nextPanel+=1
