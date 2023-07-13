extends CharacterBody2D

@export var speed = 480
@export var damage = 1
@export var pushFactor = 0.25

var exploding = false
var shooter = null

func _process(delta):
	if not exploding:
		move_and_slide()
		if global_position.distance_to(shooter.global_position) >= 400:
			queue_free()

func _on_explosion_animation_finished():
	queue_free()
	
func onFired(initialTransform):
	transform = initialTransform
	velocity = Vector2.RIGHT.rotated(get_rotation()) * speed

func _on_area_2d_body_entered(body):
	if body.has_method("takeDamage"):
		body.externalForce = velocity * pushFactor
		body.takeDamage(damage)
		exploding = true
		$Sprite2D.visible = false
		$Explosion.visible = true
		$Explosion.play("Explode")
