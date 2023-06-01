extends CharacterBody2D

@export var health = 5
var speed = 50

var target

enum STATES {IDLE, SEEK, ATTACK, DEATH}
var CURRENT_STATE = STATES.IDLE

func _ready():
	var rng = RandomNumberGenerator.new()
	$Sprite2D.frame = rng.randi_range(0, 3)
	
func _process(delta):
	if CURRENT_STATE == STATES.SEEK:
		velocity = position.direction_to(target.position) * speed
		look_at(target.position)
		if position.distance_to(target.position) > 100:
			move_and_slide()
		else:
			CURRENT_STATE = STATES.ATTACK

func takeDamage(amountDamage):
	health = health - amountDamage
	if health <= 0:
		queue_free()


func _on_vision_sphere_area_entered(area):
	print(area.get_parent().name)
	if area != null && area.get_parent().name == "Player":
		print("spotted")
		target = area.get_parent()
		CURRENT_STATE = STATES.SEEK
