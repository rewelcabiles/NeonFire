extends Node2D

export (int) var maintain_range_to_target = 300
export (bool) var can_move = true
var parent;

func _ready():
	parent = get_parent()

func AI():
	if parent.target == null:
		return null
	shoot_at_enemy()

	if can_move:
		mantain_range()
	

func mantain_range():
	var target_distance = parent.global_position.distance_to(parent.target.global_position)
	var vel = parent.global_position.direction_to(parent.target.global_position)
	if maintain_range_to_target > target_distance:
		vel *= -1
	parent.velocity = vel.normalized()
	
func shoot_at_enemy():
	var abilities = parent.get_node("Abilities").ability_1
	
	if abilities.cur_clip != 0:
		abilities.fire()
	else:
		if !abilities.reloading:
			abilities.reload()
			
