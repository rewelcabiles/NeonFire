extends "res://Dungeon/Room/Scripts/Room.gd"

func _ready():
	._ready()
	$Space_Ship/ship_camera.current = true
	$AnimationPlayer.play("Ship Entry")

func on_animation_end():
	var player = $Space_Ship/Player
	$Space_Ship.remove_child(player)
	add_child(player)
	player.transform = $Player_Spawn.transform
	player.get_node("camera").current = true
	player.input_possible = true
	$AnimationPlayer.play("Tutorial_Fade_In")
	player.HUD.get_node("AnimationPlayer").play("Fade_In")
