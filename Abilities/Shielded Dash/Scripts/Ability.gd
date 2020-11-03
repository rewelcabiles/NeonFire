extends "res://Items/Interact Pickups/Base Interact Pickup/Scripts/Base_Item.gd"


func interact(player):
	player.get_node("abilities").ability_upgrades.append(item_name)
	queue_free()
