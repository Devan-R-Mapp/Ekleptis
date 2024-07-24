extends Node2D

@onready var projectile_pool = $Projectiles
var player_spawn_point = null
var player_handle_point = null
var player_rotation = null
var projectile_speed = 500
@onready var is_Equiped = get_parent().get_parent().has_node("weapon_main_slot")
# Called when the node enters the scene tree for the first time.
func _ready():
	if is_Equiped and is_Equiped != null:
		player_spawn_point = get_parent().get_node("../SpawnPoint")
		player_handle_point = get_parent().get_node("../HandlePoint")
		
func _process(_delta):
	if is_Equiped and is_Equiped != null:
		$Barrel.global_position = player_spawn_point.global_position
		$".".global_position = player_handle_point.global_position
		player_rotation = get_parent().get_parent().get_radAngle()
		$".".rotation_degrees = rad_to_deg(player_rotation) + 45
		

func fire():
	if Input.is_action_just_pressed("Fire"):
		var projectileTemp = projectile_pool.get_projectile()
		var mouse_position = get_global_mouse_position()
		var spawn_position = $Barrel.global_position
		var lookDirection = (mouse_position - spawn_position).normalized()
		projectileTemp.velocity = lookDirection * projectile_speed
		projectileTemp.global_position = spawn_position
		projectileTemp.show()

