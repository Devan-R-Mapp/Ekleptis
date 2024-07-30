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
var resources = 1
@onready var spawnArea = Vector2(0,0)
@onready var origin = Vector2(100,100) - spawnArea


func gen_random_pos(origin_X, spawnArea_X):
	var x = randi_range(origin_X.x, spawnArea_X.x)
	var y = randi_range(origin_X.y, spawnArea_X.y)
	
	return Vector2(x, y)
	
func _ready() -> void:
	
	for portal in portal_spawn_point:
		if portal is Marker2D:
			var global_pos = portal.global_position
			spawn_mercury(5, global_pos)
			spawn_ore(5, global_pos)
			#todo Install DefenderNodes here as well


func _process(_delta):
	pass

func spawn_mercury(howMany: int, location: Vector2) -> void:
	for i in range(howMany):
		var new_mercury = mercury.instantiate()
		var randX = randi_range(-150,150)
		var randY = randi_range(-150,150)
		new_mercury.global_position = location + Vector2(randX,randY)
		get_parent().call_deferred("add_child", new_mercury)


func spawn_ore(howMany: int,  location: Vector2) -> void:
	for i in range(howMany):
		var new_ore = ore.instantiate()
		var randX = randi_range(-150,150)
		var randY = randi_range(-150,150)
		new_ore.global_position = location + Vector2(randX,randY)
		get_parent().call_deferred("add_child", new_ore)


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
		$AudioStreamPlayer2D.play()
		Wave.lightlevel = Wave.timeType.eclipse
		spawn_basic_portals(total_portals)
		eclipse_timer.start(45)
		base_portals += 1
	else: 
		Wave.lightlevel = Wave.timeType.eclipse
		$AudioStreamPlayer2D.play()
		spawn_basic_portals(total_portals)
		spawn_boss_portals(3)
		eclipse_timer.start(90)
		finalWave = true
		
	
func _on_eclipse_timer_timeout():
	if !finalWave:
		currentWave += 1
		spawn_mercury(resources, gen_random_pos(origin, spawnArea))
		spawn_ore(resources, gen_random_pos(origin, spawnArea))
		total_portals = snappedi(base_portals + (currentWave/2), 1)
		Wave.lightlevel = Wave.timeType.day
		day_timer.start(15)
		resources += 1
	else:
		Wave.lightlevel = Wave.timeType.night


func _on_spawn_timer_timeout():
	pass
