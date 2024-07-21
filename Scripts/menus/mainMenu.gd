extends Node2D

func _on_start_pressed():
	print("gamestart")
	get_tree().change_scene_to_file("res://Scenes/World/world.tscn")
	

func _on_options_pressed():
	get_tree().change_scene_to_file("")
	

func _on_quit_pressed():
	get_tree().quit()
