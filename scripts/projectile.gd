extends Node2D

@export var speed = 100
@export var damage = 50

@onready var collisions = get_node("Area2D")

func _ready():
	collisions.body_entered.connect(handleDamage)
	
func handleDamage(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
		
