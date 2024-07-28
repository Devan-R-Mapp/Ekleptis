extends CanvasLayer

@onready var display_up = $TextUp
@onready var display_down = $TextDown


func _on_open_pressed():
	display_up.visible = true
	display_down.visible = false


func _on_close_pressed():
	display_up.visible = false
	display_down.visible = true
