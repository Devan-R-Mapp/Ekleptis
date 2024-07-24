extends StaticBody2D

@onready var _cauldron_sprite = $Sprite
@onready var bar = $ProgressBar
var isAlive = true
# Called when the node enters the scene tree for the first time.
func _ready():
	_cauldron_sprite.play("bubling")
	bar.max_value = Game.cauldronHP


func _physics_process(_delta: float) -> void:
	
	if isAlive:
		bar.value = Game.cauldronHP


