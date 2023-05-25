extends Area2D
var speed = 420

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta


func _on_area_entered(area):
	if area.get_parent().has_method("takeDamage"):
		area.get_parent().takeDamage(1)
		queue_free()
