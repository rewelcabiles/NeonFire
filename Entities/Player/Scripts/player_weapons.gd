extends Node2D

export (PackedScene) onready var primary_weapon;
export (PackedScene) onready var secondary_weapon;

var current_weapon = "primary";
var can_use_weapon = true
var player

func _ready():
	player = get_parent()
	primary_weapon = primary_weapon.instance();
	player.get_node("HUD").primary_info.update_weapon(primary_weapon)
	primary_weapon.connect("property_change", player.get_node("HUD").primary_info, "update_info")
	player.call_deferred("add_child", primary_weapon);
	player.get_node("HUD").primary_info.toggle_selected(current_weapon)
	
func change_weapon(weapon):
	var hud = player.get_node("HUD")
	if (current_weapon == "primary" or primary_weapon == null) and secondary_weapon != null:
		if primary_weapon != null:
			primary_weapon.drop()
			primary_weapon.disconnect("property_change", hud.primary_info, "update_info")	
			
		primary_weapon = weapon
		hud.primary_info.update_weapon(primary_weapon)
		primary_weapon.connect("property_change", hud.primary_info, "update_info")
		primary_weapon.position = Vector2(0, 0)
		player.add_child(primary_weapon)
			
	elif (current_weapon == "secondary"  or secondary_weapon == null) and primary_weapon != null:
		if secondary_weapon != null:
			secondary_weapon.drop()
			secondary_weapon.disconnect("property_change", hud.secondary_info, "update_info")
			
		secondary_weapon = weapon
		secondary_weapon.position = Vector2(0, 0)
		hud.secondary_info.update_weapon(secondary_weapon)
		secondary_weapon.connect("property_change", hud.secondary_info, "update_info")
		player.add_child(secondary_weapon)
		
func use_weapon():
	if !can_use_weapon:
		return
		
	if current_weapon == "primary" and primary_weapon != null:
		primary_weapon.fire();
		
	elif current_weapon == "secondary" and secondary_weapon != null:
		secondary_weapon.fire();
		
func reload_weapon():
	if current_weapon == "primary":
		primary_weapon.reload()
	else:
		secondary_weapon.reload()

func switch_weapons():
	var hud = player.get_node("HUD")
	if current_weapon == "secondary" and primary_weapon != null:
		current_weapon = "primary"
	elif current_weapon == "primary" and secondary_weapon != null:
		current_weapon = "secondary"
		
	hud.primary_info.toggle_selected(current_weapon)
	hud.secondary_info.toggle_selected(current_weapon)
