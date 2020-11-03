extends "res://Items/Interact Pickups/Base Interact Pickup/Scripts/Base_Item.gd"


func interact(player):
	player.add_to_inventory(self)
