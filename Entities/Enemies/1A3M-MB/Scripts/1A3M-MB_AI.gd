extends "res://Entities/Enemies/BaseEnemy/Scripts/Movement.gd"

var current_phase = 1

onready var ability_spiral = get_parent().get_node("ability_spiral")
onready var ability_laser = get_parent().get_node("ability_laser")


func AI():
	if parent.target == null:
		return null
	if current_phase == 1:
		spiral_attack()
		laser_attack()
		
func heal():
	pass



func spiral_attack():
	if ability_spiral.can_spawn:
		ability_spiral.fire()

func laser_attack():
	if ability_laser.on == false:
		ability_laser.start()
