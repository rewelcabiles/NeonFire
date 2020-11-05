extends "res://Entities/Base Classes/Base Projectile Ability/Scripts/Base_Projectile_Ability.gd"

export (float) var projectile_count;
var radius = Vector2(60, 0)
onready var step = 2 * PI / projectile_count
var current_projectile_count = 0.0
onready var delay = $projectile_delay
var can_spawn = true		


func fire():
	if can_fire and cur_clip != 0 and !reloading:
		var projectile_arms = get_parent().get_node("AI").difficulty
		for i in range(projectile_arms):
			spawn_projectile(fmod(current_projectile_count + (i * 10.0), projectile_count))
		
		can_fire = false
		self.cur_clip -= 1
		$fire_timer.set_wait_time(fire_rate)
		$fire_timer.start();

func spawn_projectile(i):
	var spawn_pos = Vector2(0,0) + radius.rotated(step * i)
	
	var projectile = projectile_class.instance();
	projectile.z_index = -1
	
	if not get_parent().name == "Player":
		projectile.is_player_bullet(false)
		
	var angle = radius.rotated(step * i).angle()
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
