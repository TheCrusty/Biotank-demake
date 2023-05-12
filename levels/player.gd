extends CharacterBody2D

var projectile = preload("res://levels/projectile.tscn")
@export var speed = 400

func get_input():
	if Input.is_action_pressed("Shoot"):
		var projectile_instance = projectile.instantiate()
		add_child(projectile_instance)
	else:
		var input_direction = Input.get_vector("Rotate_Left", "Rotate_Right", "Forward", "Reverse")
		velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	$Sprite2D.look_at(get_global_mouse_position())
	move_and_slide()
