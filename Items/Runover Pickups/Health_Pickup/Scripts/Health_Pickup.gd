extends "res://Items/Runover Pickups/Base_Runover/Scripts/Base Runover.gd"


export (int) var amount = 3

func _on_run_over(player):
	var health = player.get_node("health")
	amount += randi() % 2
	
	if health.cur_hp == health.max_hp:
		return null
	
	health.cur_hp += amount
	if health.cur_hp > health.max_hp:
		health.cur_hp = health.max_hp
	health.update_hud()
	
	queue_free()
