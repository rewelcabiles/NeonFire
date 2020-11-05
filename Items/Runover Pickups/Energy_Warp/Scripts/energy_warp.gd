extends "res://Items/Runover Pickups/Base_Runover/Scripts/Base Runover.gd"

export (int) var amount = 5

func _on_run_over(player):
	player.energy_warp += amount
	queue_free()
