extends Control


func _ready():
	$DNABar/DNAMeter.set_value(PlayerVariables.dnaCount)

func _on_close_pressed():
	save_inventory()
	get_tree().change_scene_to_file("res://GUI/mission_select.tscn")

func save_inventory():
	var bodyItemList = []
	for Slot in $Inventory.get_node("GridContainer").get_children():
		if Slot.item != null:
			bodyItemList.append(Slot.item.itemName)
		else:
			bodyItemList.append("Empty")
	var inventoryItemList = []
	for Slot in $Inventory.get_node("GridContainer2").get_children():
		if Slot.item != null:
			inventoryItemList.append(Slot.item.itemName)
	
	PlayerVariables.body = bodyItemList
	PlayerVariables.inventory = inventoryItemList
