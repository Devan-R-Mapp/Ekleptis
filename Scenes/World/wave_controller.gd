extends Node2D

@export var portal_spawn_point: Array[Marker2D] 
@onready var eclipse_timer: = $EclipseTimer
@onready var day_timer: = $DayTimer
var bossSpawnerScene: PackedScene = preload("res://Scenes/ai/ai_mobs/ekleptis_boss_spawner.tscn")
var basicSpawnerScene: PackedScene = preload("res://Scenes/ai/ai_mobs/ekleptis_basic_spawner.tscn")
var currentWave = 1
var base_portals = 3
var total_portals = snappedi(base_portals + (currentWave/2), 1)
var finalWave = false


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
		
func spawn_basic_portals(howMany: int) -> void:
	for i in range(howMany):
		var random_spawn_number = randi_range(0, 7)
		var new_portal = basicSpawnerScene.instantiate()
		new_portal.global_position = portal_spawn_point[random_spawn_number].global_position
		get_parent().call_deferred("add_child", new_portal)


func _on_day_timer_timeout():
	if currentWave < 5:
		Wave.lightlevel = Wave.timeType.eclipse
		spawn_basic_portals(total_portals)
		eclipse_timer.start(45)
		base_portals += 1
	else: 
		Wave.lightlevel = Wave.timeType.eclipse
		spawn_basic_portals(total_portals)
		spawn_boss_portals(3)
		eclipse_timer.start(90)
		finalWave = true
		
	
func _on_eclipse_timer_timeout():
	if !finalWave:
		currentWave += 1
		total_portals = snappedi(base_portals + (currentWave/2), 1)
		Wave.lightlevel = Wave.timeType.day
		day_timer.start(15)
	else:
		Wave.lightlevel = Wave.timeType.night
