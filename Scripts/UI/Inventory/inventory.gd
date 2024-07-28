extends Resource
class_name Inventory

signal updated

@export var items: Array[InventoryItem]

func add_item(item: InventoryItem):
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			break
	
