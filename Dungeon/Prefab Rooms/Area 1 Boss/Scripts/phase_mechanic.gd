extends Node

onready var boss = get_parent().get_node("Boss")
onready var spawner = get_parent().get_node("Spawner")
var difficulty = 1
var boss_phase_start_health;
var phase = 1
var damage_done = 0
var damage_phase_threshold

func _ready():
	if !get_parent().has_node("Player"):
		var Player = load("res://Entities/Player/player.tscn").instance()
		Player.position = get_parent().get_node("debug_position").position
		Player.get_node("camera").current = true
		Player.input_possible = true
		get_parent().call_deferred("add_child", Player)
		#get_parent().add_child(test_player)
		
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
	spawner.stop(true)
	boss.get_node("ability_laser").increase_difficulty()
	boss.get_node("AI").set_phase(1)
	boss.get_node("AI").difficulty += 1


func _on_Boss_died(boss):
	print("RIP BOSS")
	var spawner = get_parent().get_node("Spawner")
	spawner.stop(true)
	spawner.queue_free()
	ending_scene()
	
func ending_scene():
	var space_ship = get_parent().get_node("Space_Ship")
	space_ship.get_node("AnimationPlayer").play("ship_arrival")

func open_doors():
	get_parent().get_node("Space_Ship").get_node("AnimationPlayer").play("doors_opening")
