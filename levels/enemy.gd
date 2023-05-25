extends Sprite2D

var health = 5

func takeDamage(amountDamage): 
	health = health - amountDamage
	if health <= 0:
		queue_free()
		
