extends HBoxContainer

var player;
export (String) var weapon_slot;

func _ready():
	player = owner.get_parent()

func toggle_selected(status):
	if status == weapon_slot:
		print("Selected")
		$"Information/HBoxContainer/Weapon Name".modulate = Color(0, 1, 0)
	else:
		$"Information/HBoxContainer/Weapon Name".modulate = Color(1, 1, 1)

func update_weapon(weapon):
	#$Border/Icon.texture = weapon.icon
	$"Information/HBoxContainer/Weapon Name".text = weapon.weapon_name
	update_info(weapon)

func update_info(weapon):
	$Information/Reserve_Ammo/Label.text = str(weapon.total_ammo)
	$Information/Current_Ammo/Label.text = str(weapon.cur_clip) + "/" + str(weapon.max_clip)


func _process(delta):
	if player != null:
		var weapons = player.get_node("weapons")
		if weapons.primary_weapon != null:
			if weapons.primary_weapon.reloading and weapon_slot == "primary":
				$Information/HBoxContainer/reload.value = int(weapons.primary_weapon.get_node("reload_timer").get_time_left() /  weapons.primary_weapon.get_node("reload_timer").wait_time * 100)
		
		if weapons.secondary_weapon != null:
			if weapons.secondary_weapon.reloading and weapon_slot == "secondary":
				$Information/HBoxContainer/reload.value = int(weapons.secondary_weapon.get_node("reload_timer").get_time_left() /  weapons.secondary_weapon.get_node("reload_timer").wait_time * 100)
