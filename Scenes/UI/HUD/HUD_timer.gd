extends CanvasLayer

@onready var label = $Control/MarginContainer/Label
@onready var time = $Control/MarginContainer/TimerDisplay
@onready var timer: Node = get_node("../../../wave_controller/DayTimer")


# Called when the node enters the scene tree for the first time.
func _ready():
	print(timer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_timer()
	pass

func update_timer():
	time.text = str(ceil(timer.time_left))
