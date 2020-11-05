extends Node

onready var boss = get_parent().get_node("Boss")
onready var spawner = get_parent().get_node("Spawner")
var difficulty = 1
var boss_phase_start_health;
var phase = 1
var damage_done = 0
var damage_phase_threshold

func _ready():
	damage_phase_threshold = boss.health * 0.3
	boss_phase_start_health = boss.health

func _process(delta):
	pass

func _on_Boss_took_damage(boss): # Start phase 2
	if phase != 1:
		return
	damage_done += boss.last_damage_taken
	if damage_done >= damage_phase_threshold:
		boss.get_node("AI").set_phase(2)
		phase = 2
		spawner.start()
		


func _on_Boss_shield_died(): # Start phase 1
	difficulty += 1
	damage_done = 0
	phase = 1
	spawner.stop()
	boss.get_node("AI").set_phase(1)
	boss.get_node("AI").difficulty += 1
