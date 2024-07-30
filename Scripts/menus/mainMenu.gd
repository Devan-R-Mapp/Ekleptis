extends Node2D

var link_to_feedback = "https://docs.google.com/forms/d/e/1FAIpQLSel_PlFJ0NL6QNbuJuzyTtn77RDW6jWXQCwRxz8NCVkKuibIw/viewform"

func _ready():
	$buttonManager/LinkButton.uri = link_to_feedback

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/World/world.tscn")
	

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/Options.tscn")
	

func _on_quit_pressed():
	get_tree().quit()


func _on_link_button_pressed():
	pass

