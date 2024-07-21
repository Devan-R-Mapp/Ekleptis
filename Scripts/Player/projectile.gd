extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.rotation += .20
	move_and_slide()


func _on_damage_box_body_entered(body):
	if body.get("isMob"):
		if body.isAlive and body.visible and self.visible:
			body.reset_mob(body)
			get_parent().reset_projectile(self)
		
