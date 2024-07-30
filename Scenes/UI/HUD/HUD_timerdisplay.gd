extends CanvasLayer

@onready var label = $Control/MarginContainer/Text
@onready var time = $Control/MarginContainer/Timer
@onready var timer: Node = get_node("../../../wave_controller/DayTimer")



func _process(_delta):
	update_timer()

func update_timer():
	time.text = str(ceil(timer.time_left))
