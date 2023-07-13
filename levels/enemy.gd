extends CharacterBody2D

@export var health = 5
@export var speed = 50
var friction = -2
var externalForce = Vector2.ZERO
var seekMovement = Vector2.ZERO
var target
var attackArea = 80
enum STATES {IDLE, SEEK, ATTACK, DEATH}
var CURRENT_STATE = STATES.IDLE

func _ready():
	var rng = RandomNumberGenerator.new()
	$Sprite2D.frame = rng.randi_range(0, 3)
	
func _process(delta):
	seekMovement = Vector2.ZERO
	if CURRENT_STATE == STATES.DEATH:
		$CollisionShape.set_disabled(true)
	if CURRENT_STATE == STATES.SEEK:
		seekMovement = position.direction_to(target.position) * speed 
		look_at(target.position)
		if position.distance_to(target.position) < attackArea:
			change_state(STATES.ATTACK)
	velocity = externalForce + seekMovement
	applyForces()
	move_and_slide()

func applyForces():
	if externalForce.length() > 5:
		externalForce *= 0.9
	if velocity.length() < 5:
		velocity = Vector2.ZERO
		externalForce = Vector2.ZERO
	
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
