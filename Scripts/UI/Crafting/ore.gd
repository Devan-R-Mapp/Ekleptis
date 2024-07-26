extends Area2D
class_name Ore


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is Player:
		if visible and body.visible:
			body.collect(self)
			queue_free()
