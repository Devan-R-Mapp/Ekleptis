extends Node2D

var tower_instance = null
var collision_shape 


func start_placing_tower(tower_scene):
	if tower_instance:
		tower_instance.queue_free()
	tower_instance = tower_scene.instantiate()
	collision_shape = tower_instance
	collision_shape.set_collision_layer_value(3, false)
	get_node("/root/fightMap").add_child(tower_instance)
	
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if tower_instance:
		tower_instance.global_position = get_global_mouse_position()
		if Input.is_action_just_pressed("click"):
			place_tower()
			
func place_tower():
	collision_shape.set_collision_layer_value(3, true)
	set_process(false)
	tower_instance = null
	
