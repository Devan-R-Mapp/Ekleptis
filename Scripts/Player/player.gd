extends CharacterBody2D

var speed: int = 225
var direction: Vector2 = Vector2(0,1)
@onready var projectile_pool = $Projectiles


func _physics_process(_delta: float) -> void:
	var inputDirection: Vector2 = Vector2(Input.get_axis("Left", "Right"),Input.get_axis("Up", "Down")).normalized()
	
	if inputDirection.x > 0:
		#Check if player is moving right
		get_node("Dwarf Model").frame = 2
		get_node("Dwarf Model").flip_h = true
		direction = inputDirection
	elif inputDirection.x < 0:
		#Check if player is moving left
		get_node("Dwarf Model").frame = 2
		get_node("Dwarf Model").flip_h = false
		direction = inputDirection
	elif inputDirection.y > 0:
		#Check if player is moving down
		get_node("Dwarf Model").frame = 1
		direction = inputDirection
	elif inputDirection.y < 0:
		#Check if player is moving up
		get_node("Dwarf Model").frame = 0
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
