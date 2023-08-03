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
var playerInSight = false
var inAttackRange = false


signal enemy_death

func _ready():
	var rng = RandomNumberGenerator.new()
	$Sprite2D.frame = rng.randi_range(0, 3)
	$AttackTimer.wait_time = attackDelay
	await owner.ready
	var player_node = get_parent().get_node("Player")
	connect("enemy_death",Callable(player_node,"_enemy_death_handler"))

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
	if health > 0:
		health = health - amountDamage
		if(health <= 0):
			$StateMachine.transition_to("Death")

func _on_vision_sphere_area_entered(area):
	if area != null && area.get_parent().name == "Player":
		target = area.get_parent()
		playerInSight = true

func _on_vision_sphere_area_exited(area):
	if area != null && area.get_parent().name == "Player":
		playerInSight = false

func _on_attack_range_body_entered(body):
	if body != null && body.name == "Player":
		inAttackRange = true

func _on_attack_range_body_exited(body):
	if body != null && body.name == "Player":
		inAttackRange = false

func _on_attack_timer_timeout():
	doAttack()
