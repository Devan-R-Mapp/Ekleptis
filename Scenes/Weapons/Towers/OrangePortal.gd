extends Area2D
class_name OrangePortal

@onready var orange_portal = $AnimatedSprite2D


func _ready():
	orange_portal.play("idle")


func _on_body_entered(body):
	if body.is_in_group("Player"):
		if body.is_in_group("Player"):
			var BP = null
			for portal in get_tree().get_nodes_in_group("Portals"):
				if portal.name == "BluePortal":
					BP = portal
					break
			if BP:
				body.global_position = BP.global_position
		
		
		


	
