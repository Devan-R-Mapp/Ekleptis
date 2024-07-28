extends StaticBody2D
class_name MagicMissleTower

@export var itemResource = InventoryItem

var health = 10

func bought(inventory: Inventory):
	inventory.add_item(itemResource)

#needs to fire a projectile

#needs to take damage when hit

#needs to disapear when dead

