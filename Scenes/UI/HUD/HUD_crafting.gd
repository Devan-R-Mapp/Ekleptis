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

var slots_selected = [false, false, false, false, false, false, false, false, false]



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
		if slots_selected[0] and !slots[0] == null:
			orePrice = 0
			mercuryPrice = 2
			if Game.ore >= orePrice && Game.mercury >= mercuryPrice:
				Game.ore -= orePrice
				Game.mercury -= mercuryPrice
				Game.weaponInternalCD = Game.weaponInternalCD - .05 #this sets the attack speed upgrade
				if Game.weaponInternalCD <= 0:
					Game.weaponInternalCD = .001
				hud_res.buy_pressed()
				print("atk spd bought")
		elif slots_selected[1] and !slots[1] == null and !Game.automatic_upgrade:
			orePrice = 0
			mercuryPrice = 2
			if Game.ore >= orePrice && Game.mercury >= mercuryPrice:
				Game.ore -= orePrice
				Game.mercury -= mercuryPrice
				Game.automatic_upgrade = true
				hud_res.buy_pressed()
				print("auto fire bought")
		elif slots_selected[2] and !slots[2] == null:
			orePrice = 0
			mercuryPrice = 2
			if Game.ore >= orePrice && Game.mercury >= mercuryPrice:
				Game.ore -= orePrice
				Game.mercury -= mercuryPrice
				Game.light_energy += .5 #this sets the light level for upgrade
				hud_res.buy_pressed()
				print("light up bought")
			
	
	
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
	

func hl_check(num):
	for i in range(upgrade_inv.items.size()):
		if i == num:
			pass
		else:	
			slots[i].un_highlight()
			slots_selected[i] = false

func _on_craft_ui_slot_pressed():
	print("slot 1 pressed")
	var num = 0
	if !slots[num] == null:
		hl_check(num)
		slots_selected[num] = true

func _on_craft_ui_slot_2_pressed():
	print("slot 2 pressed")
	var num = 1
	if !slots[num] == null:
		hl_check(num)
		slots_selected[num] = true

func _on_craft_ui_slot_3_pressed():
	print("slot 3 pressed")
	var num = 2
	if !slots[num] == null:
		hl_check(num)
		slots_selected[num] = true


func _on_craft_ui_slot_4_pressed():
	print("slot 4 pressed")
	var num = 3
	if !slots[num] == null:
		hl_check(num)
		slots_selected[num] = true


func _on_craft_ui_slot_5_pressed():
	print("slot 5 pressed")
	var num = 4
	if !slots[num] == null:
		hl_check(num)
		slots_selected[num] = true


func _on_craft_ui_slot_6_pressed():
	print("slot 6 pressed")
	var num = 5
	if !slots[num] == null:
		hl_check(num)
		slots_selected[num] = true


func _on_craft_ui_slot_7_pressed():
	print("slot 7 pressed")
	var num = 6
	if !slots[num] == null:
		hl_check(num)
		slots_selected[num] = true


func _on_craft_ui_slot_8_pressed():
	print("slot 8 pressed")
	var num = 7
	if !slots[num] == null:
		hl_check(num)
		slots_selected[num] = true


func _on_craft_ui_slot_9_pressed():
	print("slot 9 pressed")
	var num = 8
	if !slots[num] == null:
		hl_check(num)
		slots_selected[num] = true
