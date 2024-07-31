extends Node2D

var mobScene: PackedScene = preload("res://Scenes/ai/ai_mobs/ranged_shadow.tscn")
var bossScene: PackedScene = preload("res://Scenes/ai/ai_mobs/boss.tscn")
var poolSize: int = 4
var mob_pool: Array = []
var total_spawned_mobs: int = 0
var total_killed_mobs: int = 0
var boss_spawned = false
var boss: Node = bossScene.instantiate()

@onready var timer: Timer = $Timer

func _process(_delta):
	self_destruct()
	$Portal.rotation += .0075
	
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
	
func reset_mob(mob: Node, scoreUP: bool) -> void:
	mob.isAlive = false
	var tween = create_tween()
	tween.tween_property(mob, "modulate", Color8(0,0,0,0) , .25)
	mob.get_node("CollisionShape2D").set_deferred("disabled", true)
	await tween.finished
	mob.position = Vector2(-1000, -1000)
	mob_pool.pop_front()
	mob.hide()
	total_killed_mobs += 1
	if scoreUP:
		Game.basic_kills += 1



func _on_timer_timeout() -> void:
	if total_spawned_mobs <= poolSize:
		var mobTemp: Node = get_mob()
		var randX = randi_range(-10,10)
		var randY = randi_range(-10,10)
		mobTemp.global_position = self.global_position + Vector2(randX,randY)
		mobTemp.show()
		total_spawned_mobs += 1
	else:
		timer.stop()
		spawn_boss()
	

func spawn_boss() -> void:
	add_child(boss)
	var randX = randi_range(-10,10)
	var randY = randi_range(-10,10)
	boss.global_position = self.global_position + Vector2(randX,randY)  # Set the boss position
	boss_spawned = true  # Mark the boss as spawned
	total_spawned_mobs += 1
	
func self_destruct():
	if !boss.isAlive and (total_spawned_mobs == total_killed_mobs):
		var tween = create_tween().set_parallel()
		tween.tween_property($Portal, "modulate", Color8(0,0,0,0) , 2)
		tween.tween_property($Portal, "scale", Vector2(0,0) , 2)
		await tween.finished
		Game.portal_kills += 1
		queue_free()
		
