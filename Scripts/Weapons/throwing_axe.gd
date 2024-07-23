extends Node2D

@onready var projectile_pool = $Projectiles
@onready var player_spawn_point = get_parent().get_node("../SpawnPoint")
var projectile_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Barrel.global_position = player_spawn_point.global_position

func fire():
	if Input.is_action_just_pressed("Fire"):
		var projectileTemp = projectile_pool.get_projectile()
		var mouse_position = get_global_mouse_position()
		var spawn_position = $Barrel.global_position
		var lookDirection = (mouse_position - spawn_position).normalized()
		projectileTemp.velocity = lookDirection * projectile_speed
		projectileTemp.global_position = spawn_position
		projectileTemp.show()

