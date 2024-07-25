extends CharacterBody2D
class_name Player

signal collected(ore)

var player_speed: int = 225
var direction: Vector2

var spawn_distance = 30

#Weapon Varibles
@onready var weapon_main_slot = $weapon_main_slot
var current_weapon: Node2D

@onready var _animated_sprite = $"Dwarf Model"

@onready var player = $"."
@onready var ring_sprite = $AimRing
var mouse_position
var player_position
var radAngle = 0
@onready var spawn_point = $SpawnPoint
@onready var handle_point = $HandlePoint

func get_radAngle () -> float:
		return radAngle
	
func _ready () -> void:
	current_weapon = weapon_main_slot.get_child(0) 

func _physics_process(_delta: float) -> void:
	player_movement_input_handler()
	update_spawn_point_position_and_rotation()
	handle_firing()

func player_movement_input_handler():
	var inputDirection: Vector2 = Vector2(Input.get_axis("Left", "Right"),Input.get_axis("Up", "Down")).normalized()
	if inputDirection.x > 0:
		#Check if player is moving right
		_animated_sprite.play("move_right")
		direction = inputDirection
	elif inputDirection.x < 0:
		#Check if player is moving left
		_animated_sprite.play("move_left")
		direction = inputDirection
	elif inputDirection.y > 0:
		#Check if player is moving down
		_animated_sprite.play("move_down")
		direction = inputDirection
	elif inputDirection.y < 0:
		#Check if player is moving up
		_animated_sprite.play("move_up")
		direction = inputDirection
	else:
		_animated_sprite.play("Idle")
	velocity = inputDirection * player_speed
	move_and_slide()

func update_spawn_point_position_and_rotation():
		mouse_position = get_global_mouse_position()
		player_position = player.global_position
		direction = (mouse_position - player_position).normalized()
		var angle = direction.angle()
		radAngle = atan2(direction.y, direction.x)
		ring_sprite.rotation_degrees = rad_to_deg(radAngle) - 45
		spawn_point.rotation = angle
		spawn_point.global_position = player_position + direction * spawn_distance
		handle_point.global_position = player_position + direction * (spawn_distance - 20)

func handle_firing():
		if Input.is_action_just_pressed("Fire"):
			current_weapon.fire()

func collect(ore):
	collected.emit(ore)
