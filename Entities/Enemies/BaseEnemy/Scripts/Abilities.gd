extends Node2D



export (PackedScene) var ability_1_class;
export (PackedScene) var ability_2_class;


var ability_1;
var ability_2;

func _ready():
	if ability_1_class != null:
		ability_1 = ability_1_class.instance();
		get_parent().call_deferred("add_child", ability_1)
		
		
	if ability_2_class != null:
		ability_2 = ability_2_class.instance();
		get_parent().call_deferred("add_child", ability_2)
		
	
