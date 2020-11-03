extends Area2D

export (String) var item_name
export (String, MULTILINE) var description 



func interact(player):
	print("Override this function please")
	#player.add_to_inventory(self)

func _on_BaseItem_body_entered(body):
	if body.name == "Player":
		$MarginContainer/VBoxContainer/name.text = item_name
		$MarginContainer/VBoxContainer/description.text = description


func _on_BaseItem_body_exited(body):
	if body.name == "Player":
		$MarginContainer/VBoxContainer/name.text = ''
		$MarginContainer/VBoxContainer/description.text = ''
