extends Node


var resources = [
	{
		"name":"health",
		"class" : load("res://Items/Runover Pickups/Health_Pickup/Health_Pickup.tscn"),
		"chance" : 0.3,
		"guaranteed" : false
	},
	{
		"name":"ammo",
		"class" : load("res://Items/Runover Pickups/Ammo_Pickup/Ammo Pickup.tscn"),
		"chance" : 0.3,
		"guaranteed" : false
	},
	{
		"name":"energy_warp_charges",
		"class" : load("res://Items/Runover Pickups/Energy_Warp/energy_warp.tscn"),
		"chance" : 0.1,
		"guaranteed" : true
	}
	
]
