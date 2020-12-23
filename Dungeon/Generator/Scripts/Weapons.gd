extends Node

var types = [
	{
		"name" : "Energy Rifle",
		"class" : load("res://Entities/Weapons/Energy Rifle/Energy_Rifle.tscn"),
		"rarity" : "common",
		"floor_blacklist" : 0
	},
	{
		"name" : "Energy Hand Cannon",
		"class" : load("res://Entities/Weapons/Energy Hand Cannon/Energy Hand Cannon.tscn"),
		"rarity" : "common",
		"floor_blacklist" : 0
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
