extends CharacterBody2D

var isAlive = true
var isMob = true
var speed = 10
var health = 5

@onready var cauldron: Node = get_node("../../Cauldron")
@onready var sprite: Sprite2D = get_node("Sprite")
@onready var projectile_pool = $Projectiles
@onready var bar = $ProgressBar

func _physics_process(delta: float) -> void:
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
		

