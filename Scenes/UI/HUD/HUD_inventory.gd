extends CanvasLayer
class_name HUD_inventory

@onready var inventory: Inventory = preload("res://Scripts/UI/Inventory/playerInventory.tres")
@onready var slots: Array = $InvUI/MarginContainer/NinePatchRect/GridContainer.get_children()
@onready var tower_scene = preload("res://Scenes/Weapons/Towers/EyeTower.tscn")
@onready var tower_controller = get_node("../../../TowerController")

func _ready():
	update_inv()
	
func update_inv():
	print("update inv called")
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update_plr_inv(inventory.items[i])

func place_item():
	print("place called")
	tower_controller.start_placing_tower(tower_scene)
	

func _on_inv_ui_slot_pressed():
	if slots[0].plr_has_item():
		slots[0].update_plr_inv(null)
		place_item()

func _on_inv_ui_slot_2_pressed():
	place_item()


func _on_inv_ui_slot_3_pressed():
	place_item()


func _on_inv_ui_slot_4_pressed():
	place_item()


func _on_inv_ui_slot_5_pressed():
	place_item()


func _on_inv_ui_slot_6_pressed():
	place_item()
