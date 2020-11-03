extends "res://Items/Runover Pickups/Base_Runover/Scripts/Base Runover.gd"

export (int) var amount = 10

func _on_run_over(player):
	var current_weapon
	var p_weapon = player.get_node("weapons")
	
	if p_weapon.current_weapon == "primary":
		current_weapon = p_weapon.primary_weapon
	
	elif p_weapon.current_weapon == "secondary":
		current_weapon = p_weapon.secondary_weapon
	
	if current_weapon.total_ammo == current_weapon.max_total_ammo:
		return null
	
	current_weapon.total_ammo += floor(amount * current_weapon.ammo_pickup_multiplier)
	if current_weapon.total_ammo > current_weapon.max_total_ammo:
		current_weapon.total_ammo = current_weapon.max_total_ammo

	queue_free()
