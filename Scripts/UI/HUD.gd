extends CanvasLayer
class_name HUD

@onready var ore_label = %Ore
@onready var mercury_label = %Mercury

var ore_quantity = 0:
	set(new_quantity):
		ore_quantity = new_quantity
		_update_ore_label()
		
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
	if collectable is Mercury:
		mercury_quantity += 1