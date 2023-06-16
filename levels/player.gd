extends CharacterBody2D

@export var speed = 0.0
@export var max_speed = 14450.0
@export var damper = 0.015
@export var rotation_speed = 3

var projectile = preload("res://levels/projectile.tscn")
var rotation_direction = 0


func get_input(delta):
	if Input.is_action_just_pressed("Shoot"):
		var projectile_instance = projectile.instantiate()
		projectile_instance.shooter = self
		owner.add_child(projectile_instance)
		projectile_instance.transform = $TankTopPivot.global_transform
	else:
		rotation_direction = Input.get_axis("Rotate_Left", "Rotate_Right")
		if Input.is_action_pressed("Forward") or Input.is_action_pressed("Reverse"):
			speed = lerp(speed,max_speed,damper)
			velocity = transform.x * Input.get_axis("Forward", "Reverse") * (speed * delta) 
			print(speed)
		

func _physics_process(delta):
	get_input(delta)
	rotation += rotation_direction * rotation_speed * delta	
	$TankTopPivot.look_at(get_global_mouse_position())
	move_and_slide()
