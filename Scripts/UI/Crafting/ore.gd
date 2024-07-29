extends Area2D
class_name Ore


func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body is Player:
		if visible and body.visible:
			body.collect(self)
			queue_free()
