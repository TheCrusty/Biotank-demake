class_name EnemyState
extends State

var enemy: Enemy

func _ready():
	
	# waits for owner to ready first
	await owner.ready
	
	# sets enemy variable to point to the owner if it is the Enemy type
	enemy = owner as Enemy
	
	# will fail if owner is not an Enemy as it will be null
	assert(enemy != null)
	
	ready()
	
# extra ready function to override
func ready():
	pass

func update(_delta: float) -> void:
	enemy.velocity = enemy.externalForce + enemy.seekMovement
	enemy.applyForces()
	enemy.move_and_slide()
