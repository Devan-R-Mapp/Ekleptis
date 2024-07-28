extends CanvasLayer
class_name HUD_crafting


@onready var inventory: Inventory = preload("res://Scripts/UI/Inventory/playerInventory.tres")

@onready var crafting_inv: CraftingInventory = preload("res://Scripts/UI/Crafting/crafting_inv.tres")
@onready var slots: Array = $OpenPanel/MarginContainer/NinePatchRect/MarginContainer/GridContainer.get_children()

@onready var hud_inv: CanvasLayer = get_parent().get_child(1)

@onready var eye_tower: InventoryItem = preload("res://Scripts/UI/Inventory/Towers/EyeTower.tres")

@onready var open_panel = $OpenPanel
@onready var closed_panel = $ClosedPanel


var isOpen: bool = false

var page = 1
var orePrice
var mercuryPrice
var towerOwned = false



func _ready():
	closed()
	update_craft_inv()

func update_craft_inv():
	for i in range(min(crafting_inv.items.size(), slots.size())):
		slots[i].update_cft_inv(crafting_inv.items[i])

func _physics_process(delta):
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
				buy(eye_tower)
				
	
	
func swap_page_prev():
	if page == 1:
		page = 2
	if page == 2:
		page = 1
		
func swap_page_next():
	if page == 1:
		page = 2
	if page == 2:
		page = 1
		
func buy(item: InventoryItem):
	inventory.add_item(item)
	towerOwned = true
	hud_inv.update_inv()
	



