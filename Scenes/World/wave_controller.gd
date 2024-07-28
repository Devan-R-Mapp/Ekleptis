extends Node2D

@export var portal_spawn_point: Array[Marker2D] 
var bossSpawnerScene: PackedScene = preload("res://Scenes/ai/ai_mobs/ekleptis_boss_spawner.tscn")
var currentWave
var total_portals = 5



func _ready() -> void:
	Wave.lightlevel = Wave.timeType.eclipse
	spawn_portals()
	pass


func _process(_delta):
	pass


func spawn_portals():
	for i in total_portals:
		var random_spawn_number = randi_range(0, 7)
		print(random_spawn_number)
		var new_portal = bossSpawnerScene.instantiate()
		print(new_portal)
		new_portal.global_position = portal_spawn_point[random_spawn_number].global_position
		get_parent().add_child.call_deferred(new_portal)
