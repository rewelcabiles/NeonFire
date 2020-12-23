extends Node



#func dfs(room_list):
#	var visited = []
#	var stack = []
#	var cell = room_list[0]
#	stack.append(cell)
#	while stack.size() > 0:
#		cell = stack.pop_back()
#		visited.append(cell)
#		var n_list = get_neighbors(cell);
#		for n in n_list:
#			if !visited.has(n):
#				stack.append(n)
#	get_parent().get_node("Global_Vars").room_list = visited
#	print("DFS Complete")
#	return de_duplicate(visited)

func do_dfs(room_list):
	var visited = []
	var cell = room_list[0]
	recursive_dfs(visited, room_list, cell)
	get_parent().get_node("Global_Vars").room_list = visited
	check_for_duplicates(visited)
	return visited

func recursive_dfs(visited, room_list, node):
	if not (node in visited):
		visited.append(node)
		var n_list = get_neighbors(node)
		for n in n_list:
			recursive_dfs(visited, room_list, n)

func check_for_duplicates(old_list):
	var new_list = []
	for room in old_list:
		if not room in new_list:
			new_list.append(room)
		else:
			print("Huh. A duplicate path")


func get_neighbors(cell):
	var n_list = []
	for n in cell.connections:
		n_list.append(n[0])
	return n_list
	
	
