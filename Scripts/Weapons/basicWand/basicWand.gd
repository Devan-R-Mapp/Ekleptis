extends Node2D

@onready var pick_up_label = $Label
var direction: Vector2 = Vector2(0,1)
var projectile_speed = 500
var spawn_distance = 30
@onready var magazine = $Magazine
@onready var barrel = $Barrel
@onready var player = $"."
@onready var player_spawn_point = get_parent().get_node("../SpawnPoint")
var onGround = true

func _process(delta):
	$Barrel.global_position = player_spawn_point.global_position
	fire()
	

func _ready():
	pick_up_label.visible = false
	##TODO Make the following grab from the InputMap So the string can be more accessible
	pick_up_label.text = "Interact"
	
func fire():
	if Input.is_action_just_pressed("Fire"):
		var projectileTemp = magazine.get_projectile()
		var mouse_position = get_global_mouse_position()
		var barrel_position = barrel.global_position
		var look_direction = (mouse_position - barrel_position).normalized()
		var angle = look_direction.angle()
		var radAngle = atan2(look_direction.y, look_direction.x)
		projectileTemp.rotation_degrees = rad_to_deg(radAngle)+90
		projectileTemp.velocity = look_direction * projectile_speed
		projectileTemp.global_position = barrel_position
		projectileTemp.show()
		
func _on_Area2D_body_entered(body):
	if body.name == "Player" and onGround:  # Ensure you are checking for the player
		pick_up_label.visible = true
	if Input.is_action_just_pressed("Interact"):
		pass
	
func _on_Area2D_body_exited(body):
	if body.name == "Player" and onGround:
		pick_up_label.visible = false
