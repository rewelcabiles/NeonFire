extends Node

var debug_door
var random = RandomNumberGenerator.new()
var key_location;
var rooms_list
var spawner_class = load("res://Dungeon/Encounter/Spawner/Spawner.tscn");

func replace_room_with_prefab(old_room_index, new_room):
	var old_room = rooms_list[old_room_index]
	rooms_list[old_room_index] = new_room
	for connection in old_room.connections:
		new_room.connections.append(connection)
		var connected_room = connection[0]
		for connected_connection in connected_room.connections:
			if connected_connection.has(old_room):
				connected_connection[0] = new_room
	new_room.x = old_room.x
	new_room.y = old_room.y
	new_room.room_index = old_room.room_index
		
	old_room.queue_free()


func populate_level(rl):
	rooms_list = rl
	# Start Room
	replace_room_with_prefab(0, load("res://Dungeon/Prefab Rooms/Area 1/Start Room.tscn").instance())
	# Initialize Random Room Size if Not Prefab
	for room in rooms_list:
		if !room.is_prefab:
			room.randomize_room()
		room.create_door_pos()	
	
	# Initialize door connections
	for room in rooms_list:
		room.connect_doors()
	
	# Lock and Key Algo
	create_locks()
	
	# Apply Flags
	apply_room_flags()
	populate_rooms()
	
	
	
	return rooms_list
	
func apply_room_flags():
	for room in rooms_list:
		if room.flags.has("key_location"):
			continue
			
		if room.door_children.size() == 1:
			if !room.flags.has("boss_room"):
				room.flags.append("end_room")
		else:
			room.flags.append("normal_room")

func create_locks():
	random.randomize()
	var max_locks = 4
	var cur_locks = 0
	var lock_names = ["Warped Key", "Red Key", "Key Card", "Blue Key", "Key", "Green Key"]
	var current_goal = rooms_list[-1]
	current_goal.flags.append("boss_room")
	var key_class = load("res://Items/Interact Pickups/Resource_Keys/Key.tscn");
	while cur_locks <= max_locks:
		# Lock a door within the room of the goal, the room_index must be lower than the current room
		var lowest_door = null;
		for door in current_goal.door_children: 
			debug_door = door
			if lowest_door == null:
				lowest_door = door
			var current_room_index = door.connects_to.room_index
			var lowest_room_index = lowest_door.connects_to.room_index
			if current_room_index < lowest_room_index:
				lowest_door = door
		var new_key = key_class.instance();
		new_key.item_name = lock_names[randi() % lock_names.size()]
		lock_names.erase(new_key.item_name)
		lowest_door.lock_door(new_key.item_name)
		
		# Place key in any unblocked room with an index lower than the goal room
		while true:
			var key_loc_index = current_goal.room_index - random.randi_range(2, 3)
			if key_loc_index < 2:
				continue
			var key_room_location = rooms_list[key_loc_index]
			var new_key_x = random.randi_range(2, key_room_location.cur_size.x - 2)
			var new_key_y = random.randi_range(2, key_room_location.cur_size.y - 2)
			new_key.position = Vector2(new_key_x * 64, new_key_y * 64)
			key_room_location.add_child(new_key)
			key_room_location.flags.append("key_location")
			current_goal = key_room_location
			break
		cur_locks += 1

func populate_rooms():
	for room in rooms_list:
		# Key Rooms
		if room.flags.has("key_location"):
			var spawner = spawner_class.instance()
			spawner.wave_spawning = true
			spawner.wave_amount = random.randi_range(2, 5)
			spawner.difficulty = 4
			room.add_child(spawner)
		
		if room.flags.has("normal_room"):
			var spawner = spawner_class.instance()
			spawner.wave_spawning = false
			spawner.difficulty = 4
			room.add_child(spawner)
		

			
