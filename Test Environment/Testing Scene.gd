extends "res://Dungeon/Room/Scripts/Room.gd"


func _ready():
	$Player.HUD.get_node("AnimationPlayer").play("Fade_In")
	Generator.get_node("Global_Vars").room_list = [self]
	._ready()
	

