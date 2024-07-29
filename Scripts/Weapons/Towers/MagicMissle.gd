extends StaticBody2D
class_name MagicMissleTower

@export var itemResource = InventoryItem


var health = 10
var isAlive = true
var rotation_speed = .005
@onready var projectile_pool = $Projectiles
var has_projectile = 1
var target



func bought(inventory: Inventory):
	inventory.add_item(itemResource)
	
	
func _ready():
	pass

func _physics_process(_delta):
	$RayCast2D.rotation += rotation_speed
	$PointLight2D.rotation += rotation_speed
	#fire_at_shadow() Reanable shooting
	pass




func fire_at_shadow():
	if self.isAlive and has_projectile:
		if $RayCast2D.is_colliding():
			target = $RayCast2D.get_collider()
			if $RayCast2D.get_collider():
				has_projectile -= 1
				spawn_projectile(target.global_position)
	pass


func spawn_projectile(target_position: Vector2):
	var projectileTemp = projectile_pool.get_projectile()
	var direction: Vector2 = (target_position - self.global_position).normalized()
	projectileTemp.velocity = direction * 250
	var radAngle = atan2(direction.y, direction.x)
	projectileTemp.rotation_degrees = rad_to_deg(radAngle)+90
	projectileTemp.global_position = $SpawnPoint.global_position
	projectileTemp.show()
#needs to take damage when hit

#needs to disapear when dead



func _on_shoot_bullet_timeout():
	if has_projectile == 0:
		has_projectile += 1
 # Replace with function body.
