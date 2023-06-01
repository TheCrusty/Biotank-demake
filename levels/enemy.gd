extends Sprite2D

var health = 5

func _ready():
	var rng = RandomNumberGenerator.new()
	frame = rng.randi_range(0, 3)

func takeDamage(amountDamage): 
	health = health - amountDamage
	if health <= 0:
		queue_free()
