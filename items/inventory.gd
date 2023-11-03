extends Node2D

const SlotClass = preload("res://items/Slot.gd")
@onready var inventorySlots = $GridContainer
var holdingItem = null

func _ready():
	for inventorySlot in inventorySlots.get_children():
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

func _input(event):
	if holdingItem:
		holdingItem.global_position = get_global_mouse_position()
