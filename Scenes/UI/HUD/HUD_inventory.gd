extends CanvasLayer
class_name HUD_inventory

@onready var inventory: Inventory = preload("res://Scripts/UI/Inventory/playerInventory.tres")
@onready var slots: Array = $InvUI/MarginContainer/NinePatchRect/GridContainer.get_children()

func _ready():
	update()
	
func update():
	print("update called")
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
