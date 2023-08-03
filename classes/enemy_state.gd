class_name EnemyState
extends State

var enemy: Enemy

func _ready():
	
	# waits for owner to ready first
	await owner.ready
	
	# sets enemy variable to point to the owner
	enemy = owner as Enemy
	
	# ensures the state is attached to an enemy
	assert(enemy != null)

func update(_delta: float) -> void:
	enemy.velocity = enemy.externalForce + enemy.seekMovement
	enemy.applyForces()
	enemy.move_and_slide()
