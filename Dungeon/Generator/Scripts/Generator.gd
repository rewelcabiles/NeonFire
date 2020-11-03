extends Node




var room_class = load("res://Dungeon/Room/room.tscn");
var iterations = 0;

func _ready():
	randomize()
	

func generate_floor(size, room_remove_amount):
	var rooms_matrix = [];
	var rooms_list = [];
	var room_xy = size;
	var directions = [[0, -1], [1, 0], [0, 1], [-1, 0]];
		
	for x in range(room_xy):
		rooms_matrix.append([]);
		for y in range(room_xy):
			var new_room = room_class.instance();
			new_room.x = x;
			new_room.y = y;
			rooms_matrix[x].append(new_room);
	
	# Choose the initial cell, mark it as visited and push it to the stack
	var stack = [];
	#var current_room = rooms_matrix[int(randi() % room_xy)][int(randi() % room_xy)];
	var current_room = rooms_matrix[0][0];
	current_room.room_index = 0
	rooms_list.append(current_room)
	current_room.visited = 1;
	current_room.flags.append(["start"])
	stack.append(current_room);
	
	# While the stack is not empty 
	while stack.size() > 0:
		iterations += 1;
		# Pop a cell from the stack and make it a current cell
		current_room = stack.pop_back();
		
		# If the current cell has any neighbours which have not been visited 
		var neighbors = [];
		for dir_i in range(4):
			var new_x = current_room.x + directions[dir_i][0]
			var new_y = current_room.y + directions[dir_i][1]
			if !(new_x > room_xy - 1) && !(new_x < 0) && !(new_y > room_xy - 1) && !(new_y < 0):
				var temp_n = rooms_matrix[new_x][new_y];
				if temp_n.visited == 0:
					neighbors.append([temp_n, dir_i]);
		
		if neighbors.size() > 0:
			# Push the current cell to the stack
			stack.append(current_room);
			# Choose one of the unvisited neighbors
			var chosen = null
			chosen = neighbors[randi() % neighbors.size()];
			
			# Remove the wall between the current cell and the chosen cell
			chosen[0].link_parent(current_room, chosen[1]);
			
			# Mark the chosen cell as visited and push it to the stack
			chosen[0].visited = 1
			chosen[0].room_index = rooms_list.size();
			rooms_list.append(chosen[0])
			stack.append(chosen[0]);
			
	
	for _i in range(room_remove_amount):
		remove_link(rooms_list.pop_back())
	
	for room in rooms_list:
		room.add_doors()
	return rooms_list;


func remove_link(room):
	var parent_room = room.parent
	parent_room.children.erase(room)













