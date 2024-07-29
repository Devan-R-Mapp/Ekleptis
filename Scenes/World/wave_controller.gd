extends Node2D

@export var portal_spawn_point: Array[Marker2D] 
@onready var eclipse_timer: = $EclipseTimer
@onready var day_timer: = $DayTimer
@onready var spawn_timer: = $SpawnTimer
var bossSpawnerScene: PackedScene = preload("res://Scenes/ai/ai_mobs/ekleptis_boss_spawner.tscn")
var basicSpawnerScene: PackedScene = preload("res://Scenes/ai/ai_mobs/ekleptis_basic_spawner.tscn")
var ore: PackedScene = preload("res://Scenes/UI/Crafting/ore.tscn")
var mercury: PackedScene = preload("res://Scenes/UI/Crafting/Mercury.tscn")
var currentWave = 1
var base_portals = 3
var total_portals = snappedi(base_portals + (currentWave/2), 1)
var finalWave = false
var resources = 100
@onready var spawnArea = Vector2
@onready var origin = %ResourceSpawnArea.get_child(0).global_position - spawnArea


func gen_random_pos():
	var x = randi_range(origin.x, spawnArea.x)
	var y = randi_range(origin.y, spawnArea.y)
	
	return Vector2(x, y)
	
func _ready() -> void:
	pass


func _process(_delta):
	pass

func spawn_mercury(howMany: int) -> void:
	for i in range(howMany):
		var position = gen_random_pos()
		var new_mercury = mercury.instantiate()
		new_mercury.global_position = position
		get_parent().call_deferred("add_child", new_mercury)

func spawn_boss_portals(howMany: int) -> void:
	for i in range(howMany):
		var random_spawn_number = randi_range(0, 7)
		var new_portal = bossSpawnerScene.instantiate()
		new_portal.global_position = portal_spawn_point[random_spawn_number].global_position
		get_parent().call_deferred("add_child", new_portal)
		
func spawn_basic_portals(howMany: int) -> void:
	spawn_timer.start()
	for i in range(howMany):
		var random_spawn_number = randi_range(0, 7)
		var new_portal = basicSpawnerScene.instantiate()
		new_portal.global_position = portal_spawn_point[random_spawn_number].global_position
		var tween = create_tween()
		tween.tween_property(new_portal, "scale", Vector2(0,0), .01)
		tween.tween_property(new_portal, "scale", Vector2(1,1), .5)
		get_parent().call_deferred("add_child", new_portal)
	spawn_timer.stop()


func _on_day_timer_timeout():
	if currentWave < 5:
		spawn_mercury(10)
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


func _on_spawn_timer_timeout():
	pass
