extends Node2D

@onready var pick_up_label = $Label
var direction: Vector2 = Vector2(0,1)
var player_spawn_point = null
var player_handle_point = null
var player_rotation = null
var projectile_speed = 500
var spawn_distance = 30
@onready var magazine = $Magazine
@onready var barrel = $Barrel
@onready var player = $"."
var onGround = true
@onready var is_Equiped = get_parent().get_parent().has_node("weapon_main_slot")
var ready_to_fire: bool

var fire_rate: float = Game.weaponInternalCD 
var time_since_last_shot: float = 0.0


func _process(_delta):
	if is_Equiped and is_Equiped != null:
		$Barrel.global_position = player_spawn_point.global_position
		$".".global_position = player_handle_point.global_position
		player_rotation = get_parent().get_parent().get_radAngle()
		$".".rotation_degrees = rad_to_deg(player_rotation) + 35
		$InternalCD.wait_time = Game.weaponInternalCD
	

func _ready():
	if is_Equiped and is_Equiped != null:
		player_spawn_point = get_parent().get_node("../SpawnPoint")
		player_handle_point = get_parent().get_node("../HandlePoint")
		onGround = false
		
	pick_up_label.visible = false
	##TODO Make the following grab from the InputMap So the string can be more accessible
	pick_up_label.text = "Interact"
	
func fire():
	if ready_to_fire:
		var projectileTemp = magazine.get_projectile()
		var mouse_position = get_global_mouse_position()
		var barrel_position = barrel.global_position
		var look_direction = (mouse_position - barrel_position).normalized()
		var radAngle = atan2(look_direction.y, look_direction.x)
		projectileTemp.rotation_degrees = rad_to_deg(radAngle)+90
		projectileTemp.velocity = look_direction * projectile_speed
		projectileTemp.global_position = barrel_position
		projectileTemp.show()
		ready_to_fire = false
		$InternalCD.start()
		
		
		
func _on_Area2D_body_entered(body):
	if body.name == "Player" and onGround:  # Ensure you are checking for the player
		pick_up_label.visible = true
	if Input.is_action_just_pressed("Interact"):
		pass
	
func _on_Area2D_body_exited(body):
	if body.name == "Player" and onGround:
		pick_up_label.visible = false


func _on_internal_cd_timeout():
	ready_to_fire = true
