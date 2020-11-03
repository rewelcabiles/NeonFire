extends Area2D


func interact(player):
	get_parent().get_parent().remove_child(get_parent())
	player.add_child(get_parent())
	toggle_ground_item(false)


func toggle_ground_item(t):
	if t == true:
		self.visible = true
		self.monitorable = true
	else:
		self.visible = false
		self.monitorable = false

func _on_ground_item_body_entered(body):
	if body.name == "Player":
		$MarginContainer/VBoxContainer/name.text = get_parent().ability_name
		$MarginContainer/VBoxContainer/description.text = get_parent().description


func _on_ground_item_body_exited(body):
	if body.name == "Player":
		$MarginContainer/VBoxContainer/name.text = ''
		$MarginContainer/VBoxContainer/description.text = ''
