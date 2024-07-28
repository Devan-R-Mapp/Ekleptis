extends Node2D

var mobScene: PackedScene = preload("res://Scenes/ai/ai_mobs/melee_shadow_hunter.tscn")
var mobScene2: PackedScene = preload("res://Scenes/ai/ai_mobs/melee_shadow_crusher.tscn")
var poolSize: int = 9
var mob_pool: Array = []
var mob_pool2: Array = []
var total_spawned_mobs: int = 0
var total_killed_mobs: int = 0
var boss_spawned = false
var isFinishedSpawning = false

@onready var timer: Timer = $Timer

func _process(_delta):
	self_destruct()
	$Portal.rotation += .0075
	
func _ready() -> void:
	for i in range(poolSize):
		var mobTemp: Node = mobScene.instantiate()
		var mobTemp2: Node = mobScene2.instantiate()
		mobTemp.hide()
		mob_pool.append(mobTemp)
		mobTemp2.hide()
		mob_pool2.append(mobTemp2)
		add_child(mobTemp)
		add_child(mobTemp2)

func get_mob() -> Node:
	for mob in mob_pool:
		if not mob.visible:
			return mob
	var new_mob: Node = mobScene.instantiate()
	new_mob.hide()
	mob_pool.append(new_mob)
	add_child(new_mob)
	return new_mob
	
func get_mob2() -> Node:
	for mob in mob_pool2:
		if not mob.visible:
			return mob
	var new_mob: Node = mobScene2.instantiate()
	new_mob.hide()
	mob_pool2.append(new_mob)
	add_child(new_mob)
	return new_mob
	
func reset_mob(mob: Node, scoreUP: bool) -> void:
	mob.isAlive = false
	var tween = create_tween()
	tween.tween_property(mob, "modulate", Color8(0,0,0,0) , .25)
	mob.get_node("CollisionShape2D").set_deferred("disabled", true)

	await tween.finished
	mob.position = Vector2(-1000, -1000)
	mob_pool.pop_front()
	mob.hide()
	Game.basic_kills += 1
	total_killed_mobs += 1
	print(total_killed_mobs)

func _on_timer_timeout() -> void:
	if total_spawned_mobs < poolSize:
		spawn_mob_1()
		spawn_mob_2()
	else:
		timer.stop()
		isFinishedSpawning = true
		print(isFinishedSpawning)
		print(total_spawned_mobs)
		
func spawn_mob_1():
		var mobTemp: Node = get_mob()
		var randX = randi_range(-10,0)
		var randY = randi_range(-10,0)
		mobTemp.global_position = self.global_position + Vector2(randX, randY)
		print(mobTemp)
		mobTemp.show()
		total_spawned_mobs += 1
		
func spawn_mob_2():
		var mobTemp2: Node = get_mob2()
		var randX2 = randi_range(0,10)
		var randY2 = randi_range(0,10)
		mobTemp2.global_position = self.global_position + Vector2(randX2, randY2)
		print(mobTemp2)
		mobTemp2.show()
		total_spawned_mobs += 1
	

func self_destruct():
	if isFinishedSpawning and (total_spawned_mobs == total_killed_mobs):
		var tween = create_tween().set_parallel()
		tween.tween_property($Portal, "modulate", Color8(0,0,0,0), 2)
		tween.tween_property($Portal, "scale", Vector2(0,0), 2)
		await tween.finished
		Game.portal_kills += 1
		queue_free()
