extends CharacterBody2D

var speed: int = 225
var direction: Vector2 = Vector2(0,1)
@onready var projectile_pool = $Projectiles


func _physics_process(delta: float) -> void:
	var inputDirection: Vector2 = Vector2(Input.get_axis("Left", "Right"),Input.get_axis("Up", "Down")).normalized()
	
	if inputDirection.x > 0:
		#Check if player is moving right
		direction = inputDirection
	elif inputDirection.x < 0:
		#Check if player is moving left
		direction = inputDirection
	elif inputDirection.y > 0:
		#Check if player is moving down
		direction = inputDirection
	elif inputDirection.y < 0:
		#Check if player is moving up
		direction = inputDirection
		
		
	$SpawnPoint.position = direction*10
	if Input.is_action_just_pressed("Fire"):
		##TODO Make A Projectile That fires to a Mouse Cursor
		var projectileTemp = projectile_pool.get_projectile()
		projectileTemp.velocity = direction * 500
		projectileTemp.global_position = $SpawnPoint.global_position
		projectileTemp.show()
		
	velocity = inputDirection * speed
	move_and_slide()
