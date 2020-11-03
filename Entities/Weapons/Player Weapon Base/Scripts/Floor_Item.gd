extends Area2D


func interact(player):
	var weapon = get_parent()
	weapon.get_parent().remove_child(weapon)
	#player.add_child(weapon)
	weapon.toggle_ground_item(false)
	player.get_node("weapons").change_weapon(weapon)


func _on_floor_item_body_entered(body):
	if body.name == "Player":
		$weapon_name.text = get_parent().weapon_name


func _on_floor_item_body_exited(body):
	if body.name == "Player":
		$weapon_name.text = ""
