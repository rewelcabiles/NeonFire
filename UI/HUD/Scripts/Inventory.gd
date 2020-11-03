extends VBoxContainer


func _ready():
	pass # Replace with function body.


func update_items(inventory):
	$Item_List.text = ""
		
	for item in inventory:
		$Item_List.text += item.item_name + "\n" 

func _on_Button_pressed():
	$Item_List.visible = false if $Item_List.visible else true
