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
	
# extra ready function to override, avoids buggy _ready overriding
func ready():
	pass


func update(_delta: float) -> void:
	enemy.velocity = enemy.externalForce + enemy.seekMovement
	enemy.applyForces()
	enemy.move_and_slide()

func takeDamage(damageAmount):
	if enemy.health > 0:
		enemy.health = enemy.health - damageAmount
		if(enemy.health <= 0):
			state_machine.transition_to("Death")

func handle_vision_sphere_area_entered(area):
	enemy.target = area.get_parent()
	enemy.playerInSight = true

func handle_vision_sphere_area_exited(area):
	enemy.playerInSight = false

func handle_attack_range_body_entered(body):
	enemy.inAttackRange = true

func handle_attack_range_body_exited(body):
	enemy.inAttackRange = false
