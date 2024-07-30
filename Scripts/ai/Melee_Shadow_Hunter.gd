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

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	bar.max_value = health

func _physics_process(_delta: float) -> void:
	if isAlive:
		update_health_bar()
		move_towards_target()
		handle_sprite_orientation()
	else:
		hide_mob()

func update_health_bar() -> void:
	bar.value = health

func move_towards_target() -> void:
	if isAlive and self.visible:
		var direction = (navigation_agent.get_next_path_position() - global_position).normalized()
		velocity = speed * direction
		move_and_slide()

func handle_sprite_orientation() -> void:
	sprite.flip_h = velocity.x < 0

func hide_mob() -> void:
	sprite.hide()
	bar.hide()

func make_path_to_player() -> void:
	if player:
		navigation_agent.target_position = player.global_position

func reset_mob() -> void:
	if health > 1:
		health -= 1
	else:
		get_parent().reset_mob(self, true)

func _on_player_detection_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		if visible and body.visible:
			Game.playerHP -= 1
			get_parent().reset_mob(self, false)

func _on_pathfinding_timer_timeout() -> void:
	make_path_to_player()
