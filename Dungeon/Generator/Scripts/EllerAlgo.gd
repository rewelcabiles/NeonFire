extends Node

var room_class = load("res://Dungeon/Room/room.tscn");

func de_duplicate(old_list):
	var new_list = []
	for room in old_list:
		if not room in new_list:
			new_list.append(room)
		else:
			print("Huh. A duplicate")
	return new_list

func generate_floor(size, _room_remove_amount):
	randomize()
	var rooms_matrix = [];
	var rooms_list = [];
	var room_xy = size;
	var room_x = room_xy - 1
	var room_y = room_xy - 1
	get_parent().get_node("Global_Vars").floor_x = room_x
	get_parent().get_node("Global_Vars").floor_y = room_y
	# ==========================================
	#var sets = []
	
	for y in range(room_y):
		rooms_matrix.append([]);
		for x in range(room_x):
			var new_room = room_class.instance();
			new_room.x = x;
			new_room.y = y;
			new_room.room_set = null;
			rooms_list.append(new_room)
			rooms_matrix[y].append(new_room);
	
	# For each row…
	var iter = 0
	for y in range(room_y):
		# From left to right – Each square is given a set number if it doesn’t already have one.

		for x in range(room_x):
			var cell = rooms_matrix[y][x]
			if cell.room_set == null:
				cell.room_set = iter;
				iter += 1;
				
		# From left to right – Randomly join different sets together. If the tiles are already from the same set do not join them together.
		for x in range(room_x):
			if x == room_x - 1:
				break
			var cell = rooms_matrix[y][x]
			var adj_cell = rooms_matrix[y][x + 1]
			if cell.room_set != adj_cell.room_set:
				if (randi() % 2) == 1:
					cell.links_door(adj_cell, 3)
					for cells in rooms_matrix[y]:
						if cells.room_set == adj_cell.room_set:
							cells.room_set = cell.room_set
					
		# Connect down
		if y == room_y - 1:
			for x in range(room_x):
				if x == room_x - 1:
					break
				var cell = rooms_matrix[y][x]
				var adj_cell = rooms_matrix[y][x + 1]
				if cell.room_set != adj_cell.room_set:
					cell.links_door(adj_cell, 3)
					for cells in rooms_matrix[y]:
						if cells.room_set == adj_cell.room_set:
							cells.room_set = cell.room_set
		else:
			var row_set = []
			for cell in rooms_matrix[y]:
				var found = false
				for set in row_set:
					if cell.room_set == set[0].room_set:
						set.append(cell)
						found = true
				if found == false:
					row_set.append([cell])
			for set in row_set:
				var cell = set[randi() % set.size()]
				var adj_cell = rooms_matrix[cell.y + 1][cell.x]
				adj_cell.links_door(cell, 2)
				adj_cell.room_set = cell.room_set

	print("Ellers Algo Complete")
	return de_duplicate(rooms_list)


func remove_link(room):
	for connections in room.connections:
		var own_connection = [room, room.door_mirror[connections[1]]]
		connections[0].connections.erase(own_connection)
		













