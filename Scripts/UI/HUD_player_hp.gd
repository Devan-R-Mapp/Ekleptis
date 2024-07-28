extends CanvasLayer
class_name player_hp

@onready var player: Player = get_node("../../../Player")
@onready var player_bar = $PlayerHP/PlayerHP

@onready var cauldron: Node = get_node("../../../Cauldron") 
@onready var cauldron_bar = $CauldronHP/CauldronHP


func _ready():
	player_bar.max_value = Game.playerHP
	cauldron_bar.max_value = Game.cauldronHP
	
func _physics_process(_delta: float) -> void:
	if player.isAlive:
		player_bar.value = Game.playerHP
	if cauldron.isAlive:
		cauldron_bar.value = Game.cauldronHP


