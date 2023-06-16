extends Area2D

@export var speed = 480
@export var damage = 1

var exploding = false

var shooter = null

func _process(delta):
	if not exploding:
		position += transform.x * speed * delta
		if global_position.distance_to(shooter.global_position) >= 400:
			queue_free()

func _on_explosion_animation_finished():
	queue_free()


func _on_body_entered(body):
	if body.has_method("takeDamage"):
		body.takeDamage(damage)
		exploding = true
		$Sprite2D.visible = false
		$Explosion.visible = true
		$Explosion.play("Explode")
