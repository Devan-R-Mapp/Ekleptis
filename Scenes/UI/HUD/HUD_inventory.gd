extends CanvasLayer
class_name HUD_inventory

@onready var inventory: Inventory = preload("res://Scripts/UI/Inventory/playerInventory.tres")
@onready var slots: Array = $InvUI/MarginContainer/NinePatchRect/GridContainer.get_children()
@onready var tower_scene = preload("res://Scenes/Weapons/Towers/EyeTower.tscn")
@onready var tower_controller = get_node("../../../TowerController")

func _ready():
	clear_inv()
	update_inv()
	
func update_inv():
	print("update inv called")
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update_plr_inv(inventory.items[i])
		
func clear_inv():
	for i in range(inventory.items.size()):
		inventory.items.remove_at(i)

func place_item():
	tower_controller.start_placing_tower(tower_scene)
	

func _on_inv_ui_slot_pressed():
	if slots[0].plr_has_item():
		slots[0].update_plr_inv(null)
		place_item()

func _on_inv_ui_slot_2_pressed():
	if slots[1].plr_has_item():
		slots[1].update_plr_inv(null)
		place_item()


func _on_inv_ui_slot_3_pressed():
	if slots[2].plr_has_item():
		slots[2].update_plr_inv(null)
		place_item()


func _on_inv_ui_slot_4_pressed():
	if slots[3].plr_has_item():
		slots[3].update_plr_inv(null)
		place_item()


func _on_inv_ui_slot_5_pressed():
	if slots[4].plr_has_item():
		slots[4].update_plr_inv(null)
		place_item()


func _on_inv_ui_slot_6_pressed():
	if slots[5].plr_has_item():
		slots[5].update_plr_inv(null)
		place_item()
