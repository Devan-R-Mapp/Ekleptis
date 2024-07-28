extends Node2D

@export var portal_spawn_point: Array[Marker2D] 
@onready var eclipse_timer: = $EclipseTimer
@onready var day_timer: = $DayTimer
var bossSpawnerScene: PackedScene = preload("res://Scenes/ai/ai_mobs/ekleptis_boss_spawner.tscn")
var currentWave
var total_portals = 5



func _ready() -> void:
	pass


func _process(_delta):
	pass


func spawn_boss_portals(howMany: int) -> void:
	for i in range(howMany):
		var random_spawn_number = randi_range(0, 7)
		var new_portal = bossSpawnerScene.instantiate()
		new_portal.global_position = portal_spawn_point[random_spawn_number].global_position
		get_parent().call_deferred("add_child", new_portal)


func _on_day_timer_timeout():
	Wave.lightlevel = Wave.timeType.eclipse
	spawn_boss_portals(total_portals)
	eclipse_timer.start(60)

	
func _on_eclipse_timer_timeout():
	Wave.lightlevel = Wave.timeType.day
	day_timer.start(20)

