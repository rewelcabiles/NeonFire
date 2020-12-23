extends Node

func dfs(room_list):
	var visited = []
	var stack = []
	var cell = room_list[0]
	stack.append(cell)
	while stack.size() > 0:
		cell = stack.pop_back()
		visited.append(cell)
		var n_list = get_neighbors(cell);
		for n in n_list:
			if !visited.has(n):
				stack.append(n)
	get_parent().get_node("Global_Vars").room_list = visited
	print("DFS Complete")
	return visited



func get_neighbors(cell):
	var n_list = []
	for n in cell.connections:
		n_list.append(n[0])
	return n_list
	
	
