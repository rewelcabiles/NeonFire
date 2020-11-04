extends Node

onready var boss = get_parent().get_node("Boss")

var difficulty = 1
var boss_phase_start_health;

var damage_done = 0
var damage_phase_threshold

func _ready():
	damage_phase_threshold = boss.health * 0.3
	boss_phase_start_health = boss.health

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Boss_took_damage(boss):
	damage_done += boss.last_damage_taken
	if damage_done >= damage_phase_threshold:
		boss.get_node("AI").set_phase(2)


func _on_Boss_shield_died():
	difficulty += 1
	damage_done = 0
	boss.get_node("AI").set_phase(1)
	boss.get_node("AI").difficulty += 1
