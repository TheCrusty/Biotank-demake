extends CharacterBody2D

@export var health = 5
var speed = 50
var target
var attackArea = 80
enum STATES {IDLE, SEEK, ATTACK, DEATH}
var CURRENT_STATE = STATES.IDLE

func _ready():
	var rng = RandomNumberGenerator.new()
	$Sprite2D.frame = rng.randi_range(0, 3)
	
func _process(delta):
	if CURRENT_STATE == STATES.DEATH:
		pass
	if CURRENT_STATE == STATES.SEEK:
		velocity = position.direction_to(target.position) * speed
		look_at(target.position)
		if position.distance_to(target.position) > attackArea:
			move_and_slide()
		else:
			change_state(STATES.ATTACK)

func takeDamage(amountDamage):
	health = health - amountDamage
	if health <= 0:
		change_state(STATES.DEATH)
		$Sprite2D.frame = 4

func _on_vision_sphere_area_entered(area):
	if area != null && area.get_parent().name == "Player":
		target = area.get_parent()
		change_state(STATES.SEEK)

func _on_vision_sphere_area_exited(area):
	if area != null && area.get_parent().name == "Player":
		change_state(STATES.IDLE)
		
func change_state(state):
	if CURRENT_STATE != STATES.DEATH:
		CURRENT_STATE = state