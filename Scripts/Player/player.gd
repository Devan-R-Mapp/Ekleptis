extends CharacterBody2D

var speed: int = 225
var direction: Vector2 = Vector2(0,1)
var projectile_speed = 500
var spawn_distance = 30
@onready var weapon = $MainWeaponSlot
@onready var projectile_pool = $Projectiles
@onready var _animated_sprite = $"Dwarf Model"
@onready var spawn_point = $SpawnPoint
@onready var player = $"."
@onready var ring_sprite = $AimRing
var mouse_position
var player_position

func _process(delta):
	update_spawn_point_position_and_rotation()
	handle_firing()

func _physics_process(_delta: float) -> void:
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
	velocity = inputDirection * speed
	move_and_slide()


func update_spawn_point_position_and_rotation():
		mouse_position = get_global_mouse_position()
		player_position = player.global_position
		var direction = (mouse_position - player_position).normalized()
		var angle = direction.angle()
		var radAngle = atan2(direction.y, direction.x)
		ring_sprite.rotation_degrees = rad_to_deg(radAngle) - 45
		spawn_point.rotation = angle
		spawn_point.global_position = player_position + direction * spawn_distance
	
func handle_firing():
	if Input.is_action_just_pressed("Fire"):
		var projectileTemp = projectile_pool.get_projectile()
		var mouse_position = get_global_mouse_position()
		var spawn_position = spawn_point.global_position
		var lookDirection = (mouse_position - spawn_position).normalized()
		projectileTemp.velocity = lookDirection * projectile_speed
		projectileTemp.global_position = spawn_position
		projectileTemp.show()
	else: 
		#weapon.fire()
		pass

