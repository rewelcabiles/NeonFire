extends Node

var types = [
	{
		"name" : "Shielded Dash",
		"class" : load("res://Abilities/Shielded Dash/shielded_dash.tscn"),
		"rarity" : "common",
		"floor_blacklist" : 3
	},
	{
		"name" : "Resource UP",
		"class" : load("res://Abilities/Resource UP!/resource_up.tscn"),
		"rarity" : "common",
		"floor_blacklist" : 3
	}
]

var spawned = []

func get_drop_table():
	var drop_table = {
		"common" : [],
		"uncommon" : [],
		"rare" : [],
		"legendary" : []
	}
	
	for type in types:
		drop_table[type["rarity"]].append(type)
	
	return drop_table

func  _ready():
	pass
