extends Button
class_name craft_ui_slot

@onready var BG: Sprite2D = $Background
@onready var Highlight: Sprite2D = $Highlight
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/Item

var slot_item = null
var toggle = false

func update_cft_inv(item: InventoryItem):
	
	if !item:
		slot_item = null
		itemSprite.visible = false
		itemSprite.texture = null
	else:
		slot_item = item 
		itemSprite.visible = true
		itemSprite.texture = item.texture

func cft_has_item() -> bool:
	if slot_item == null:
		return false
	else:
		return true
		


func _on_pressed():
	
	if !toggle:
		BG.visible = false
		Highlight.visible = true
		toggle = !toggle
	else:
		BG.visible = true
		Highlight.visible = false
		toggle = !toggle
		
	
