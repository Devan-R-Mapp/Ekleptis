extends Button
class_name craft_ui_slot

@onready var itemSprite: Sprite2D = $CenterContainer/Panel/Item

func update(item: InventoryItem):
	if !item:
		itemSprite.visible = false
	else:
		itemSprite.visible = true
		itemSprite.texture = item.texture

