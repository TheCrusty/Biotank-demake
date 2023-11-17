extends Panel

var item = null

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
