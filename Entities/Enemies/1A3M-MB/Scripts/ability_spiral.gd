extends "res://Entities/Base Classes/Base Projectile Ability/Scripts/Base_Projectile_Ability.gd"

export (int) var projectile_count;
var radius = Vector2(60, 0)
onready var step = 2 * PI / projectile_count
var current_projectile_count = 0
onready var delay = $projectile_delay
var can_spawn = true		
		
func spawn_projectiles():
	
	var i = current_projectile_count
	var aim = get_parent().get_node("Aim")
	var spawn_pos = Vector2(0,0) + radius.rotated(step * i)
	
	var projectile = projectile_class.instance();
	projectile.z_index = -1
	
	if not get_parent().name == "Player":
		projectile.is_player_bullet(false)
		
	var angle = radius.rotated(step * i).angle()# + aim.transform.get_rotation()
	var new_transform = Transform2D(angle, spawn_pos + get_parent().position)
	projectile.transform = new_transform;
	get_parent().get_parent().add_child(projectile)
	
	current_projectile_count += 1
	if current_projectile_count == projectile_count:
		current_projectile_count = 0
	
	can_spawn = false
	delay.start()
	
func _on_projectile_delay_timeout():
	can_spawn = true
