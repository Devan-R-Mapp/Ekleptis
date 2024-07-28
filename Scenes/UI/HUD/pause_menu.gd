extends CanvasLayer
class_name PauseMenu

var paused = false
@onready var PM = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if !paused:
			PM.visible = true
			paused = !paused
			get_tree().paused = true
		elif paused:
			PM.visible = false
			paused = !paused
			get_tree().paused = false
			

func _on_resume_pressed():
	PM.visible = false
	get_tree().paused = false
	paused = false



func _on_quit_pressed():
	get_tree().quit()
