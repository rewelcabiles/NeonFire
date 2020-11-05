extends Node


var resources = [
	{
		"name":"health",
		"class" : load("res://Items/Runover Pickups/Health_Pickup/Health_Pickup.tscn"),
		"chance" : 0.5
	},
	{
		"name":"ammo",
		"class" : load("res://Items/Runover Pickups/Ammo_Pickup/Ammo Pickup.tscn"),
		"chance" : 0.5
	},
	{
		"name":"energy_warp_charges",
		"class" : load("res://Items/Runover Pickups/Energy_Warp/energy_warp.tscn"),
		"chance" : 1.0
	}
	
]
