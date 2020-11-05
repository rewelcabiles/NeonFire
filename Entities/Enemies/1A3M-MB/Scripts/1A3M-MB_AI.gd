extends "res://Entities/Enemies/BaseEnemy/Scripts/Movement.gd"

var current_phase = 1
var difficulty = 1

onready var ability_spiral = get_parent().get_node("ability_spiral")
onready var ability_laser = get_parent().get_node("ability_laser")
onready var ability_heal = get_parent().get_node("ability_heal")
var ability_shield_class = load("res://Entities/Enemies/1A3M-MB/1ABM_Shield_Ability.tscn")
var ability_shield


func AI():
	if parent.target == null:
		return null
	laser_attack()
	if current_phase == 1:
		spiral_attack()

func set_phase(phase):
	if phase == 1:
		if current_phase == 2:
			ability_shield.queue_free()
		current_phase = phase
	if phase == 2:
		ability_shield = ability_shield_class.instance()
		ability_shield.connect("shield_died", get_parent(), "_on_ability_shield_shield_died")
		get_parent().add_child(ability_shield)
			
		ability_heal.start()
		current_phase = 2

func spiral_attack():
	if ability_spiral.can_spawn:
		ability_spiral.fire()

func laser_attack():
	if ability_laser.on == false:
		ability_laser.start()



