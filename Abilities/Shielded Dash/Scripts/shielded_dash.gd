extends "res://Abilities/Base_Ability/Scripts/Base_Ability.gd"

func _physics_process(_delta):
	if get_parent().name != "Player":
		return
		
	var player = get_parent()
	var dash = player.get_node("dash")
	
	if dash.get_node("dash_timer").time_left > 0:
		dash.get_node("dash_particle").emitting = true
		player.get_node("health").invulnerable = true
		player.get_node("weapons").can_use_weapon = false
		
	else:
		dash.get_node("dash_particle").emitting = false
		player.get_node("health").invulnerable = false
		player.get_node("weapons").can_use_weapon = true
