extends Node2D

@onready var pause_menu = $Player/pauseMenu
var paused = false

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _process(_delta):
	game_end_conditions()
	
	
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		get_tree().paused = false
	else:
		pause_menu.show()
		get_tree().paused = true
	
	paused = !paused
	
func game_end_conditions():
	
	if Game.playerHP <= 0 or Game.cauldronHP <= 0 :
		Game.playerHP = Game.base_playerHP
		Game.cauldronHP = Game.base_cauldronHP
		get_tree().change_scene_to_file("res://Scenes/Menus/game_over.tscn")
		##TODO reset Game here

