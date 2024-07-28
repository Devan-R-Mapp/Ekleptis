extends Control

var paused = false
@onready var pause_menu = $"."


func _process(_delta):
	
	
	if Input.is_action_just_pressed("pause"):
		if !paused:
			pause_menu.show()
			paused = true
			get_tree().paused = true
		else:
			pause_menu.hide()
			paused = false
			get_tree().paused = false
		
		
func _on_resume_pressed():
		pause_menu.hide()
		paused = false
		get_tree().paused = false
		
func _on_quit_pressed():
		get_tree().quit()
