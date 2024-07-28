extends Node2D

@onready var player = $Player
@onready var hud = $HUD/HUD_resources

@onready var boss_spawner: PackedScene = preload("res://Scenes/ai/ai_mobs/ekleptis_boss_spawner.tscn")

@onready var pause_menu = $Player/pauseMenu
var paused = false


func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	
	if !player.collected.is_connected(hud._on_collected):
		player.collected.connect(hud._on_collected)
	

func _process(_delta):
	game_end_conditions()
	light_level()
	
	
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

func light_level():
	if is_inside_tree():
		if Wave.lightlevel == Wave.timeType.day:
			var tween = create_tween()
		#tween.tween_property($SUN, "color" , Color8(0,0,0,0) , 5)
			tween.tween_property($SUN, "energy" , 0 , 5)
		
		if Wave.lightlevel == Wave.timeType.eclipse:
			var tween = create_tween()
			tween.tween_property($SUN, "energy" , 1.25 , 5)
		#tween.tween_property($SUN, "color" , Color8(204,251,234,255) , 5)
		if Wave.lightlevel == Wave.timeType.night:
			var tween = create_tween()
			tween.tween_property($SUN, "energy" , 5 , 5)
		#tween.tween_property($SUN, "color", Color8(204,251,234,255) , 5)


