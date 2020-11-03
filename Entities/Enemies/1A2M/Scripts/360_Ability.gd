extends "res://Entities/Base Classes/Base Projectile Ability/Scripts/Base_Projectile_Ability.gd"

export (int) var projectile_count;
var radius = Vector2(60, 0)


func spawn_projectiles():
	var step = 2 * PI / projectile_count
	for i in range(projectile_count):
		var aim = get_parent().get_node("Aim")
		var spawn_pos = Vector2(0,0) + radius.rotated(step * i)
		var projectile = projectile_class.instance();
		
		if not get_parent().name == "Player":
			projectile.is_player_bullet(false)

		var angle = radius.rotated(step * i).angle() + aim.transform.get_rotation()
		var new_transform = Transform2D(angle, spawn_pos + get_parent().position)
		projectile.transform = new_transform;
		get_parent().get_parent().add_child(projectile)

