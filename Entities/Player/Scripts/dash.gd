extends Node2D


export var dash_speed_bonus = 300
export (float) var dash_length = 0.6

var player;

func _ready():
	player = get_parent()

func dash():
	if !$dash_timer.time_left > 0:
		player.speed = player.base_speed + dash_speed_bonus
		$dash_timer.start(dash_length)


func _on_dash_timer_timeout():
	player.speed = player.base_speed

