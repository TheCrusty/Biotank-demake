extends Panel

var ItemClass = preload("res://items/item.tscn")
var item = null

func _ready():
	if randi() % 3 == 0:
		item = ItemClass.instantiate()
		add_child(item)

func takeFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null

func placeInSlot(newItem):
	item = newItem
	item.position = Vector2.ZERO
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)
