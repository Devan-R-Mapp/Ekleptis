extends Control

@onready var score = $Score
@onready var score2 = $Score2
func _ready():
	var basic = str(Game.basic_kills)
	var boss = str(Game.boss_kills)
	var portals = str(Game.portal_kills)
	var total = str((Game.portal_kills * 0.5) + (Game.boss_kills * 2) + (Game.basic_kills))
	
	score.text = "Your score is: "  + total
	score2.text = "Basic kills: " + basic + " Boss kills: " + boss + " Portal kills: " + portals 

func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://Scenes/World/world.tscn")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
