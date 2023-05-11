extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("Rotate_Left", "Rotate_Right", "Forward", "Reverse")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	look_at(get_global_mouse_position())
	move_and_slide()
