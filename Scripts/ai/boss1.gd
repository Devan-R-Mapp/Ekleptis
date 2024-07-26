extends CharacterBody2D

var isAlive = true
var has_rock = 0
var isMob = true
var speed = 10
var health = 5

@onready var cauldron: Node = get_node("../../Cauldron")
@onready var player: Node = get_node("../../Player")
@onready var sprite: Sprite2D = get_node("Sprite")
@onready var projectile_pool = $Projectiles
@onready var bar = $ProgressBar
@onready var navigation_agent:= $NavigationAgent2D as NavigationAgent2D

func _ready():
	bar.max_value = health
	print(get_parent())

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

func make_path_to_cauldron() -> void:
	navigation_agent.target_position = cauldron.global_position
	
func reset_mob(body: Node)-> void:
	if health > 1:
		health -= 1
	else:
		isAlive = false
		get_parent().reset_mob(body)
		
func _on_shoot_bullet_timeout():
	if has_rock <= 0:
		has_rock += 1
	 # Replace with function body.

func shoot_projectile()-> void:
	if self.isAlive and has_rock >= 0:
		if $RayCast2D.is_colliding():
			if $RayCast2D.get_collider() == player:
				spawn_projectile(player.global_position)
			if $RayCast2D.get_collider() == cauldron:
				spawn_projectile(cauldron.global_position)

func spawn_projectile(target_position: Vector2):
	var projectileTemp = projectile_pool.get_projectile()
	var direction: Vector2 = (target_position - self.global_position).normalized()
	projectileTemp.velocity = direction * 250
	projectileTemp.global_position = $SpawnPoint.global_position
	projectileTemp.show()
	has_rock -= 1

func _on_navigation_timer_timeout():
	make_path_to_cauldron()
