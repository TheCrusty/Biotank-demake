extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.5

var projectile = preload("res://levels/projectile.tscn")
var rotation_direction = 0


func get_input():
	if Input.is_action_just_pressed("Shoot"):
		var projectile_instance = projectile.instantiate()
		owner.add_child(projectile_instance)
		projectile_instance.transform = $TankTopPivot.global_transform
	else:
		rotation_direction = Input.get_axis("Rotate_Left", "Rotate_Right")
		velocity = transform.x * Input.get_axis("Forward", "Reverse") * speed


func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta	
	$TankTopPivot.look_at(get_global_mouse_position())
	move_and_slide()
