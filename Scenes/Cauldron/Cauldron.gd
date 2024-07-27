extends StaticBody2D

@onready var _cauldron_sprite = $Sprite
var isAlive = true
# Called when the node enters the scene tree for the first time.
func _ready():
	_cauldron_sprite.play("bubling")
	



