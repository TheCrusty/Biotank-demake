extends Area2D

@export var speed = 480
@export var damage = 1

var exploding = false

func _process(delta):
	if not exploding:
		position += transform.x * speed * delta

func _on_area_entered(area):
	if area.get_parent().has_method("takeDamage"):
		area.get_parent().takeDamage(damage)
		exploding = true
		$Sprite2D.visible = false
		$Explosion.visible = true
		$Explosion.play("Explode")

func _on_explosion_animation_finished():
	queue_free()
