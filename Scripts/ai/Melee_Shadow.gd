extends CharacterBody2D

var isAlive = true
var speed = 20
var isMob = true
@onready var cauldron: Node = get_node("../../Cauldron")
@onready var sprite: Sprite2D = get_node("MeleeShadow")

func _physics_process(_delta: float) -> void:
	
	if isAlive:
		var direction: Vector2 = (cauldron.global_position - self.global_position).normalized()
		velocity = speed * direction
		move_and_slide()
		
		if direction.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		sprite.hide()
			
func reset_mob(body: Node)-> void:
	get_parent().reset_mob(body)
