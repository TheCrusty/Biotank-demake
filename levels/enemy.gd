extends Sprite2D

@export var health = 5

enum STATES {IDLE, SEEK, ATTACK, DEATH}
var CURRENT_STATE = STATES.IDLE

func _ready():
	var rng = RandomNumberGenerator.new()
	frame = rng.randi_range(0, 3)

func takeDamage(amountDamage): 
	health = health - amountDamage
	if health <= 0:
		queue_free()
