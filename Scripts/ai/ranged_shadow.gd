extends CharacterBody2D

var isAlive = true
var speed = 20
var isMob = true
var health: int = 3

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
		var angle = direction.angle()
		var radAngle = atan2(direction.y, direction.x)
		$RayCast2D.rotation_degrees = rad_to_deg(radAngle)
		velocity = speed * direction
		move_and_slide()
		
		shoot_projectile()
		
		
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
		isAlive = false
		get_parent().reset_mob(body)


func _on_player_detection_body_entered(body: Node2D):
	if "Player" in body.name:
		if visible and body.visible:
			Game.playerHP -= 1
	if "cauldron" in body.name:
		if visible and body.visible:
			Game.cauldronHP -= 1
			
		
func _on_shoot_bullet_timeout():
	if has_projectile <= 0:
		has_projectile += 1
	
	pass # Replace with function body.

func shoot_projectile()-> void:
	if self.isAlive and has_projectile:
		if $RayCast2D.is_colliding():
			if $RayCast2D.get_collider() == player:
				has_projectile -= 1
				spawn_projectile(player.global_position)
			if $RayCast2D.get_collider() == cauldron:
				spawn_projectile(cauldron.global_position)
		

func spawn_projectile(target_position: Vector2):
	var projectileTemp = projectile_pool.get_projectile()
	var direction: Vector2 = (target_position - self.global_position).normalized()
	projectileTemp.velocity = direction * 250
	projectileTemp.global_position = $SpawnPoint.global_position
	projectileTemp.show()

func _on_pathfinding_timer_timeout():
	make_path_to_player()
	pass # Replace with function body.
