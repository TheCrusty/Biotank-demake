extends Node2D

var items = {
	"Cannon": preload("res://items/Cannon.tscn"),
	"Barb": preload("res://items/Barb.tscn")
}

func getItemScene(name):
	if items[name] != null:
		return items[name].instantiate()
	else:
		print("Error :: Item not found!")
