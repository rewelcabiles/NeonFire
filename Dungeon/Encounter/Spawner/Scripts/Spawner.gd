extends Node

signal all_enemies_dead

export (bool) var wave_spawning = false
export (int) var wave_amount = 3
export (int) var wave_time_between = 24
export (int) var amount = 4
export (int) var difficulty = 4
export (float) var initial_delay = 0.1
export (bool) var lock_on_enter = true

var spawn_particle_class = load("res://Dungeon/Encounter/Spawner/Assets/Spawn Particle.tscn");
var current_wave = 0
var spawned_enemies  = []
var room;
var rng = RandomNumberGenerator.new()


func _ready():
	room = get_parent()
	if lock_on_enter:
		for door in get_parent().door_children:
			door.lock_door("No Enemies")
	
	Generator.get_node("Global_Vars").update_map()
	$initial_delay.start(initial_delay)

func get_random_spawn_point(as_world = true):
	rng.randomize()
	var x = rng.randi_range(3, room.cur_size.x - 3)
	var y = rng.randi_range(3, room.cur_size.y - 3)
	if as_world:
		return room.get_node("floor_tiles").map_to_world(Vector2(x, y))
	else:
		return Vector2(x, y)

func start():
	if wave_spawning:
		spawn_enemies()
		current_wave += 1
		$wave_timer.start(wave_time_between)
	else:
		spawn_enemies()

func spawn_enemies():
	var G_Enemy = Generator.get_node("Enemies")
	var current_difficulty = 0;
	var remaining = difficulty
	var enemy_lists = []
	while current_difficulty < difficulty:
		var possible_enemies = []
		for enemy in G_Enemy.enemies:
			if enemy.difficulty <= remaining:
				possible_enemies.append(enemy)
		var enemy = possible_enemies[rng.randi_range(0, possible_enemies.size() - 1)]
		current_difficulty += enemy.difficulty
		remaining = difficulty - current_difficulty
		var enemy_instance = enemy["class"].instance()
		enemy_instance.position = get_random_spawn_point()
		enemy_instance.connect("died", self, "enemy_died")
		spawned_enemies.append(enemy_instance)
		var spawn_particles = spawn_particle_class.instance()
		spawn_particles.enemy_to_spawn = enemy_instance
		spawn_particles.position = enemy_instance.position
		get_parent().call_deferred("add_child", spawn_particles)
		#get_parent().call_deferred("add_child", enemy_instance)

func enemy_died(enemy):
	spawned_enemies.erase(enemy)
	spawn_resource(enemy)
	if spawned_enemies.size() == 0:
		if wave_spawning == true and current_wave < wave_amount:
			$wave_timer.start(1)
			$wave_timer.wait_time = wave_time_between
		else:
			if lock_on_enter:
				for door in get_parent().door_children:
					door.unlock_door("No Enemies")
					Generator.get_node("Global_Vars").update_map()
			emit_signal("all_enemies_dead")

func spawn_resource(enemy):
	var resources = Generator.get_node("Resources").resources
	var max_amount_to_spawn = enemy.difficulty + 1
	for _i in range(max_amount_to_spawn):
		if randi() % 2 == 1:
			var new_resource = resources[rng.randi_range(0, resources.size() - 1)]["class"].instance()
			new_resource.position = enemy.position
			new_resource.set_global_rotation_degrees(rng.randi_range(0, 360))
			new_resource.speed = rng.randi_range(100, 350)
			get_parent().add_child(new_resource)

func _on_wave_timer_timeout():
	if current_wave >= wave_amount:
		$wave_timer.stop()
	current_wave += 1
	spawn_enemies()

func _on_start_timer_timeout():
	start()



func _on_initial_delay_timeout():
	$start_timer.start()
