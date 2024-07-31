extends CanvasLayer
class_name HUD_resources

@onready var ore_label = %Ore
@onready var mercury_label = %Mercury

@export var inventory_item: InventoryItem


var ore_quantity = 0:
	set(new_quantity):
		ore_quantity = new_quantity
		_update_ore_label()


func buy_pressed():
	ore_quantity = Game.ore
	mercury_quantity = Game.mercury

		
var mercury_quantity = 0:
	set(new_quantity):
		mercury_quantity = new_quantity
		_update_mercury_label()
		

func _ready():
	_update_ore_label()
	_update_mercury_label()

	
func _update_ore_label():
	ore_label.text = str(ore_quantity)
	
func _update_mercury_label():
	mercury_label.text = str(mercury_quantity)
	
func _on_collected(collectable) -> void:
	if collectable is Ore:
		ore_quantity += 1
		Game.ore = ore_quantity
	if collectable is Mercury:
		mercury_quantity += 1
		Game.mercury = mercury_quantity
