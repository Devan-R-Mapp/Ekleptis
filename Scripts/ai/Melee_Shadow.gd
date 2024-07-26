extends CharacterBody2D

var isAlive = true
var speed = 20
var isMob = true
var health: int = 1

@onready var cauldron: Node = get_node("../../Cauldron")
@onready var sprite: Sprite2D = get_node("MeleeShadow")
@onready var projectile_pool = $Projectiles
@onready var bar = $ProgressBar


func _ready():
	bar.max_value = health
	

func _physics_process(_delta: float) -> void:
	
	if isAlive:
		bar.value = health

		var direction: Vector2 = (cauldron.global_position - self.global_position).normalized()
		velocity = speed * direction
		move_and_slide()
		
		if direction.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		sprite.hide()
		bar.hide()
			
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
	shoot_projectile()
	pass # Replace with function body.

func shoot_projectile()-> void:
	if self.isAlive:

		var projectileTemp = projectile_pool.get_projectile()
		var direction: Vector2 = (cauldron.global_position - self.global_position).normalized()
		projectileTemp.velocity = direction * 500
		projectileTemp.global_position = $SpawnPoint.global_position
		projectileTemp.show()
		
