extends Node2D

var items = {
	"Cannon": preload("res://scenes/items/cannon/Cannon.tscn"),
	"Barb": preload("res://scenes/items/barb/Barb.tscn"),
	"Blunderbuss": preload("res://scenes/items/blunderbuss/Blunderbuss.tscn"),
	"Spike": preload("res://scenes/items/spike/spike.tscn"),
	"Laser": preload("res://scenes/items/laser/laser.tscn")
}

func getItemScene(name):
	if items[name] != null:
		return items[name].instantiate()
	else:
		print("Error :: Item not found!")
