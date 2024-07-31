extends Area2D
class_name BluePortal

@onready var blue_portal = $AnimatedSprite2D



# Called when the node enters the scene tree for the first time.
func _ready():
	blue_portal.play("idle")


func _on_body_entered(body):
	if body.is_in_group("Player"):
		var OP = null
		for portal in get_tree().get_nodes_in_group("Portals"):
			if portal.name == "OrangePortal":
				OP = portal
				break
		if OP:
			body.global_position = OP.global_position
		


