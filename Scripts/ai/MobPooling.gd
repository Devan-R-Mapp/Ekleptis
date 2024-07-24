extends Node2D

var mobScene: PackedScene = preload("res://Scenes/ai/ai_mobs/Melee_Shadow.tscn")
var bossScene: PackedScene = preload("res://Scenes/ai/ai_mobs/boss.tscn")
var poolSize: int = 5
var mob_pool: Array = []
var total_spawned_mobs: int = 0
var boss_spawned = false

@onready var timer: Timer = $Timer

func _process(delta):
	self_destruct()
	
func _ready() -> void:
	for i in range(poolSize):
		var mobTemp: Node = mobScene.instantiate()
		mobTemp.hide()
		mob_pool.append(mobTemp)
		add_child(mobTemp)

func get_mob()-> Node:
	for mob in mob_pool:
		if not mob.visible:
			return mob
	var new_mob:Node = mobScene.instantiate()
	new_mob.hide()
	mob_pool.append(new_mob)
	add_child(new_mob)
	return new_mob
	
func reset_mob(mob: Node) -> void:
	mob.position = Vector2(-1000, -1000)
	mob.get_node("CollisionShape2D").set_deferred("disabled", true)
	mob.isAlive = false
	print(mob_pool.size())
	mob_pool.pop_front()
	mob.hide()


func _on_timer_timeout() -> void:
	if total_spawned_mobs <= poolSize:
		var mobTemp: Node = get_mob()
		var randX = randi_range(-50,50)
		var randY = randi_range(-50,50)
		mobTemp.global_position = self.global_position + Vector2(randX,randY)
		mobTemp.show()
		print("mobs called = " + str(total_spawned_mobs))
		total_spawned_mobs += 1
	else:
		timer.stop()
		spawn_boss()
	
func spawn_boss() -> void:
	var boss: Node = bossScene.instantiate()
	add_child(boss)
	boss.global_position = self.global_position  # Set the boss position
	boss_spawned = true  # Mark the boss as spawned
	
func self_destruct():
	if !bossScene.isAlive and boss_spawned == false:
		pass
