extends "res://Entities/Enemies/BaseEnemy/Scripts/Movement.gd"

var current_phase = 1
var difficulty = 1

onready var ability_spiral = get_parent().get_node("ability_spiral")
onready var ability_laser = get_parent().get_node("ability_laser")
onready var ability_shield = get_parent().get_node("ability_shield")
onready var ability_heal = get_parent().get_node("ability_heal")



func AI():
	if parent.target == null:
		return null
	if current_phase == 1:
		spiral_attack()
		laser_attack()

func set_phase(phase):
	if phase == 1:
		if current_phase == 2:
			ability_shield.toggle_shields(false)
			
		current_phase = phase
	if phase == 2:
		if ability_shield.enabled == false:
			ability_shield.toggle_shields(true)
		ability_heal.start()
		current_phase = 2

func spiral_attack():
	if ability_spiral.can_spawn:
		ability_spiral.fire()

func laser_attack():
	if ability_laser.on == false:
		ability_laser.start()



