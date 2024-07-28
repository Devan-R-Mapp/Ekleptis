extends Node

var projectileScene: PackedScene = preload("res://Scenes/ai/ai_projectiles/aiprojectile.tscn")
var poolSize: int = 5
var projectile_pool: Array = []

func _ready() -> void:
	for i in range(poolSize):
		var projectileTemp: Node = projectileScene.instantiate()
		projectileTemp.hide()
		projectile_pool.append(projectileTemp)
		add_child(projectileTemp)

func get_projectile()-> Node:
	for projectile in projectile_pool:
		if not projectile.visible:
			return projectile
	var new_projectile:Node = projectileScene.instantiate()
	new_projectile.hide()
	projectile_pool.append(new_projectile)
	add_child(new_projectile)
	return new_projectile
	
func reset_projectile(projectile: Node) -> void:
	projectile.global_position = Vector2(-1000, -1000)
	projectile.hide()
