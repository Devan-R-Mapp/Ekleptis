extends Node2D

@onready var player = $Player
@onready var hud = $Player/HUD/HUD_resources
var paused = false


func _ready():
	
	Game.basic_kills = 0
	Game.boss_kills = 0
	Game.portal_kills = 0
	Wave.lightlevel = Wave.timeType.day
	process_mode = Node.PROCESS_MODE_PAUSABLE
	
	Game.weaponInternalCD = .5
	Game.automatic_upgrade = false
	
	if !player.collected.is_connected(hud._on_collected):
		player.collected.connect(hud._on_collected)
	

func _process(_delta):
	game_end_conditions()
	light_level()
	
	
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




func _on_instructions_timer_timeout():
		var tween = create_tween().set_parallel()
		tween.tween_property($Instructions, "modulate", Color8(0,0,0,0) , 2)
		tween.tween_property($Instructions, "scale", Vector2(0,0) , 2)

