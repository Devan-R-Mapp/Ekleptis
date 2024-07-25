extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.rotation += .005
	move_and_slide()


func _on_damage_box_body_entered(body):
	if "Player" in body.name:
		if visible and body.visible:
			Game.playerHP -= 5
			get_parent().reset_projectile(self)
	if "Cauldron" in body.name:
		if visible and body.visible:
			Game.cauldronHP -= 10
			get_parent().reset_projectile(self)
		


func _on_despawn_timer_timeout():
	##TODO WHY WONT THIS KILL THE PROJECTILE
	get_parent().reset_projectile(self)
