extends CharacterBody2D

var isAlive = true
var speed = 50
var isMob = true
var health: int = 1

@onready var cauldron: Node = get_node("../../Cauldron")
@onready var player: Node = get_node("../../Player")
@onready var sprite: Sprite2D = get_node("MeleeShadow")
@onready var projectile_pool = $Projectiles
@onready var bar = $ProgressBar
var has_projectile = 0

@onready var navigation_agent:= $NavigationAgent2D as NavigationAgent2D


func _ready():
	bar.max_value = health
	

func _physics_process(_delta: float) -> void:
	if isAlive:
		bar.value = health

		var direction = (navigation_agent.get_next_path_position() - global_position).normalized()
		velocity = speed * direction
		move_and_slide()

		
		if direction.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		sprite.hide()
		bar.hide()
			
func make_path_to_player() -> void:
	if(player):
		navigation_agent.target_position = player.global_position

func reset_mob(body: Node)-> void:
	if health > 1:
		health -= 1
	else:
		get_parent().reset_mob($".", true)
		


func _on_player_detection_body_entered(body: Node2D):
	if "Player" in body.name:
		if visible and body.visible:
			Game.playerHP -= 1
			get_parent().reset_mob($".", false)

		
	
	pass # Replace with function body.


func _on_pathfinding_timer_timeout():
	make_path_to_player()
	pass # Replace with function body.
