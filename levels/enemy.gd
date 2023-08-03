class_name Enemy
extends CharacterBody2D

@export var health = 5
@export var speed = 50
@export var type = "melee"
@export var damage = 2
@export var attackDelay = 2.0
var friction = -2
var externalForce = Vector2.ZERO
var seekMovement = Vector2.ZERO
var target
var projectile = preload("res://levels/enemy_projectile.tscn")

enum STATES {IDLE, SEEK, ATTACK, DEATH}
var CURRENT_STATE = STATES.IDLE

func _ready():
	var rng = RandomNumberGenerator.new()
	$Sprite2D.frame = rng.randi_range(0, 3)
	$AttackTimer.wait_time = attackDelay
	
func _process(delta):
	seekMovement = Vector2.ZERO
	if CURRENT_STATE == STATES.DEATH:
		$CollisionShape.set_disabled(true)
	if CURRENT_STATE == STATES.SEEK:
		seekMovement = position.direction_to(target.position) * speed 
		look_at(target.position)
	velocity = externalForce + seekMovement
	applyForces()
	move_and_slide()

func applyForces():
	#Shrinks the value of an applied external force over time kind of like LERP
	if externalForce.length() > 5:
		externalForce *= 0.9
	#Resets the values, basically functions like MathFloor
	if velocity.length() < 5:
		velocity = Vector2.ZERO
		externalForce = Vector2.ZERO

func doAttack():
	look_at(target.position)
	if type == "melee":
		target.takeDamage(damage)
		$AnimationPlayer.play("meleeAttackAnimation")
	else:
		var projectile_instance = projectile.instantiate()
		projectile_instance.shooter = self
		owner.add_child(projectile_instance)
		projectile_instance.onFired(global_transform)

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
	if CURRENT_STATE == STATES.DEATH:
		return
	if state == STATES.DEATH:
		$AttackTimer.stop()
		$AttackRange.set_monitoring(false)
	CURRENT_STATE = state

func _on_attack_range_body_entered(body):
	if body != null && body.name == "Player":
		$AttackTimer.start()
		change_state(STATES.ATTACK)

func _on_attack_range_body_exited(body):
	if body != null && body.name == "Player":
		$AttackTimer.stop()
		change_state(STATES.SEEK)

func _on_attack_timer_timeout():
	doAttack()
