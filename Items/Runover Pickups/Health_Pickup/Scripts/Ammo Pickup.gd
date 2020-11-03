extends "res://Entities/Interactable/Runover Pickups/Base Runover/Scripts/Base Runover.gd"

export (int) var amount = 10

func _on_run_over(player):
	var current_weapon
	amount += randi() % 11
	if current_weapon.total_ammo == current_weapon.max_total_ammo:
		return null
		
	if player.current_weapon == "primary":
		current_weapon = player.primary_weapon
	
	elif player.current_weapon == "secondary":
		current_weapon = player.secondary_weapon
	
	current_weapon.total_ammo += amount
	if current_weapon.total_ammo > current_weapon.max_total_ammo:
		current_weapon.total_ammo = current_weapon.max_total_ammo

	queue_free()
