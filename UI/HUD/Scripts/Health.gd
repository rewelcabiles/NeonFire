extends VBoxContainer



func update_health(max_hp, cur_hp):
	var new_val = (0.0+ cur_hp)/max_hp * 100
	$Health_Bar/Progress_Bar.value = new_val
	$Health_Bar/Health_Label.text = str(new_val) + "%"
	
