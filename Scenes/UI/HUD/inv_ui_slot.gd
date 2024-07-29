extends Button

@onready var bgSprite: Sprite2D = $Background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/Item

var slot_item = null

func _ready():
	slot_item = null

func update_plr_inv(item: InventoryItem):
	if !item:
		slot_item = null
		itemSprite.visible = false
		itemSprite.texture = null
	else:
		slot_item = item 
		itemSprite.visible = true
		itemSprite.texture = item.texture

func plr_has_item() -> bool:
	if slot_item == null:
		return false
	else:
		return true
		
func get_item() -> InventoryItem:
	return slot_item
