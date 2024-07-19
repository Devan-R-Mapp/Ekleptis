extends Node2D

var mobScene: PackedScene = preload("res://Scenes/ai/Melee_Shadow.tscn")
var poolSize: int = 15
var mob_pool: Array = []
@onready var timer: Timer = $Timer



func _ready() -> void:
	for i in range(poolSize):
		var mobTemp: Node = mobScene.instantiate()
		mobTemp.hide()
		mob_pool.append(mobTemp)
		add_child(mobTemp)

func get_mob()-> Node:
	for mob in mob_pool:
		if not mob.visible :
			return mob
	var new_mob:Node = mobScene.instantiate()
	new_mob.hide()
	mob_pool.append(new_mob)
	add_child(new_mob)
	return new_mob
	
func reset_mob(mob: Node) -> void:
	mob.global_position = Vector2(-1000, -1000)
	mob.get_node("CollisionShape2D").set_deferred("disabled", true)
	mob.isAlive = false
	mob.hide()

func _on_timer_timeout() -> void:
	var mobTemp: Node = get_mob()
	var randX = randi_range(-50,50)
	var randY = randi_range(-50,50)
	mobTemp.global_position = self.global_position + Vector2(randX,randY)
	mobTemp.show()

