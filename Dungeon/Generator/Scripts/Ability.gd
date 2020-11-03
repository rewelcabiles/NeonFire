extends Node

var abilities = [
	{
		"name" : "Shielded Dash",
		"class" : load("res://Abilities/Shielded Dash/Shielded Dash.tscn"),
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
	
	for ability in abilities:
		drop_table[ability["rarity"]].append(ability)
	
	return drop_table

func  _ready():
	pass
