extends StaticBody2D
class_name Cauldron

@onready var _cauldron_sprite = $Sprite
var isAlive = true

func _ready():
	_cauldron_sprite.play("bubling")
	

func _on_crafting_zone_body_entered(body):
	if body.has_method("player_craft"):
		print("craft zone")
