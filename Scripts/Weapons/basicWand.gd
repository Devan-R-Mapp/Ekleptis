extends Node2D

@onready var pick_up_label = $Label
var direction: Vector2 = Vector2(0,1)
var projectile_speed = 500
var spawn_distance = 30
@onready var magazine = $Magazine
@onready var barrel = $Barrel
@onready var player = $"."
var onGround = true

func _process(delta):
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
		var lookDirection = (mouse_position - barrel_position).normalized()
		projectileTemp.velocity = lookDirection * projectile_speed
		projectileTemp.global_position = barrel_position
		projectileTemp.show()
		pass
		
func _on_Area2D_body_entered(body):
	if body.name == "Player" and onGround:  # Ensure you are checking for the player
		pick_up_label.visible = true
	if Input.is_action_just_pressed("Interact"):
		pass
	
func _on_Area2D_body_exited(body):
	if body.name == "Player" and onGround:
		pick_up_label.visible = false
