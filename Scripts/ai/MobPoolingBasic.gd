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

func get_mob(pool: Array, scene: PackedScene) -> Node:
	for mob in pool:
		if not mob.visible:
			return mob
	var new_mob: Node = scene.instantiate()
	new_mob.hide()
	pool.append(new_mob)
	add_child(new_mob)
	return new_mob

func reset_mob(mob: Node, scoreUP: bool) -> void:
	mob.isAlive = false
	var tween = create_tween()
	tween.tween_property(mob, "modulate", Color8(0,0,0,0), .25)
	mob.get_node("CollisionShape2D").set_deferred("disabled", true)
	await tween.finished
	mob.position = Vector2(-1000, -1000)
	mob.hide()
	Game.basic_kills += 1
	total_killed_mobs += 1

func _on_timer_timeout() -> void:
	if total_spawned_mobs < poolSize:
		spawn_mob(mob_pool, mobScene, Vector2(randi_range(-10,0), randi_range(-10,0)))
		spawn_mob(mob_pool2, mobScene2, Vector2(randi_range(0,10), randi_range(0,10)))
	else:
		timer.stop()
		isFinishedSpawning = true

func spawn_mob(pool: Array, scene: PackedScene, rand_offset: Vector2):
	var mobTemp: Node = get_mob(pool, scene)
	mobTemp.global_position = self.global_position + rand_offset
	mobTemp.show()
	total_spawned_mobs += 1

func self_destruct():
	if isFinishedSpawning and (total_spawned_mobs == total_killed_mobs):
		var tween = create_tween().set_parallel()
		tween.tween_property($Portal, "modulate", Color8(0,0,0,0), 2)
		tween.tween_property($Portal, "scale", Vector2(0,0), 2)
		await tween.finished
		Game.portal_kills += 1
		queue_free()
