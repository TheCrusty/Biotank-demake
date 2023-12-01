extends Node2D

const SlotClass = preload("res://items/Slot.gd")
const possibleItems = [
	preload("res://items/barb.tscn"), 
	preload("res://items/cannon.tscn")
] 

@onready var inventorySlots = $GridContainer
@onready var inventorySlots2 = $GridContainer2
var holdingItem = null

func _ready():
	populate_storage_grid()
	populate_body_grid()
	for inventorySlot in inventorySlots.get_children():
		inventorySlot.gui_input.connect(slotGuiInput.bind(inventorySlot))
	for inventorySlot in inventorySlots2.get_children():
		inventorySlot.gui_input.connect(slotGuiInput.bind(inventorySlot))


func slotGuiInput(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if holdingItem != null:
				print("placing")
				if !slot.item:
					slot.placeInSlot(holdingItem)
					holdingItem = null
				else:
					var tempItem = slot.item
					slot.takeFromSlot()
					tempItem.global_position = event.global_position
					slot.placeInSlot(holdingItem)
					holdingItem = tempItem
			elif slot.item:
				holdingItem = slot.item
				slot.takeFromSlot()
				holdingItem.global_position = get_global_mouse_position()


func populate_body_grid():
	var storageInventory = $GridContainer
	var slots = storageInventory.get_children()
	var nextFreeSlot = 0
	for item in PlayerVariables.body:
		if item != "Empty":
			print(item)
			var scene = $ItemLoader.getItemScene(item)
			slots[nextFreeSlot].placeInSlot(scene)
		nextFreeSlot += 1

		
# this will be replaced once we can drop/pickup items.
func populate_storage_grid():
	var storageInventory = $GridContainer2
	for slot in storageInventory.get_children():
		# We are using size +1 because if our array would go out of bounds we won't put an item.
		var random = randi() % (possibleItems.size() + 1)
		if random != possibleItems.size():
			slot.placeInSlot(possibleItems[random].instantiate())


func _input(event):
	if holdingItem:
		holdingItem.global_position = get_global_mouse_position()
