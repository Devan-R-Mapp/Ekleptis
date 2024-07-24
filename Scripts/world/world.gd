extends Node2D

@onready var pause_menu = $Player/pauseMenu
var paused = false

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _process(_delta):
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
	

