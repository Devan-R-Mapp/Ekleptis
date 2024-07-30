extends CanvasLayer
class_name HUD_crafting


@onready var inventory: Inventory = preload("res://Scripts/UI/Inventory/playerInventory.tres")
@onready var crafting_inv: CraftingInventory = preload("res://Scripts/UI/Crafting/crafting_inv.tres")
@onready var upgrade_inv: UpgradeInventory = preload("res://Scripts/UI/Crafting/upgrade_inventory.tres")
@onready var slots: Array = $OpenPanel/MarginContainer/NinePatchRect/MarginContainer/GridContainer.get_children()

@onready var hud_inv: CanvasLayer = get_parent().get_child(1)
@onready var hud_res: CanvasLayer = get_parent().get_child(0)

@onready var eye_tower: InventoryItem = preload("res://Scripts/UI/Inventory/Towers/EyeTower.tres")

@onready var open_panel = $OpenPanel
@onready var closed_panel = $ClosedPanel
@onready var craft_buy_button = $OpenPanel/MarginContainer/NinePatchRect/Craft


var isOpen: bool = false

var page = 1
var orePrice
var mercuryPrice
var towerOwned = false

var slot_1_selected = false
var slot_2_selected = false
var slot_3_selected = false



func _ready():
	closed()
	update_craft_inv()
	
	

func update_craft_inv():
	print("update called")
	if page == 1:
		for i in range(min(crafting_inv.items.size(), slots.size())):
			slots[i].update_cft_inv(crafting_inv.items[i])
	elif page == 2:
		for i in range(min(upgrade_inv.items.size(), slots.size())):
			slots[i].update_cft_inv(upgrade_inv.items[i])

func _physics_process(_delta):
	if Game.crafting_zone == true:
		open()
		
	else:
		closed()

func open():
	open_panel.visible = true
	closed_panel.visible = false
	isOpen = true
	
func closed():
	open_panel.visible = false
	closed_panel.visible = true
	isOpen = false

func _on_prev_pressed():
	swap_page_prev()


func _on_next_pressed():
	swap_page_next()

func _on_buy_pressed():
	if page == 1:
		orePrice = 1
		mercuryPrice = 0
		if Game.ore >= orePrice && Game.mercury >= mercuryPrice:
			if towerOwned == false:
				craft(eye_tower)
				Game.ore -= orePrice
				Game.mercury -= mercuryPrice
				hud_res.buy_pressed()
	elif page == 2:
		
		pass
			
	
	
func swap_page_prev():
	if page == 1:
		page = 2
		craft_buy_button.text = "Buy"
		update_craft_inv()
	elif page == 2:
		page = 1
		craft_buy_button.text = "Craft"
		update_craft_inv()
		
func swap_page_next():
	if page == 1:
		page = 2
		craft_buy_button.text = "Buy"
		update_craft_inv()
	elif page == 2:
		page = 1
		craft_buy_button.text = "Craft"
		update_craft_inv()
		
func craft(item: InventoryItem):
	inventory.add_item(item)
	towerOwned = true
	hud_inv.update_inv()
	


func _on_craft_ui_slot_pressed():
	print("slot 1 pressed")
	slot_1_selected = !slot_1_selected

func _on_craft_ui_slot_2_pressed():
	print("slot 2 pressed")
	slot_2_selected = !slot_2_selected

func _on_craft_ui_slot_3_pressed():
	print("slot 3 pressed")
	slot_3_selected = !slot_3_selected
