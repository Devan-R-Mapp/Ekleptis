extends CharacterBody2D

var speed: int = 225
var direction: Vector2 = Vector2(0,1)
@onready var projectile_pool = $Projectiles
@onready var _animated_sprite = $"Dwarf Model"


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
		_animated_sprite.stop()
		
		
	$SpawnPoint.position = direction*10
	if Input.is_action_just_pressed("Fire"):
		##TODO Make A Projectile That fires to a Mouse Cursor
		var projectileTemp = projectile_pool.get_projectile()
		projectileTemp.velocity = direction * 500
		projectileTemp.global_position = $SpawnPoint.global_position
		projectileTemp.show()
		
	velocity = inputDirection * speed
	move_and_slide()
