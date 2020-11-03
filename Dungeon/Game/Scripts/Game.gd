extends Node2D

var player_class = load("res://Entities/Player/player.tscn");
var player;

var current_room;
var floor_1;
var floor_2;
var floor_3;
var global_vars = Generator.get_node("Global_Vars")
var door_mirror = {0:2, 1:3, 2:0, 3:1}

func _ready():
	MusicManager.play_music("EndlessBlue")
	floor_1 = Generator.get_node("Eller").generate_floor(5, 0)
	var path = Generator.get_node("DFS").dfs(floor_1)
	
	for room_index in range(path.size()):
		var c = path[room_index]
		c.room_index = room_index
		c.get_node("Label").text = "X: "+str(c.x) + " Y:" + str(c.y) + " RI:" + str(c.room_index)
		
	path = Generator.get_node("Populator").populate_level(path)
	current_room = path[0]
	# Set to true for debug
	if false:
		var current_x = 0
		var current_y = 0
		for rooms in path:
			var room_x = rooms.cur_size.x * 80 * rooms.x
			var room_y = rooms.cur_size.y * 80 * rooms.y
			rooms.set_position(Vector2(room_x, room_y))
			add_child(rooms)
		$debug_camera.current = true
		
		

func _on_player_transition(door_obj):
	print("Game Transition")
	var next_room = door_obj.connects_to;
	var amount = 80
	if door_obj.location == 0:
		player.set_position(door_obj.door_partner.position + Vector2(64, -amount));
	if door_obj.location == 1:
		player.set_position(door_obj.door_partner.position + Vector2(amount, 64));
	if door_obj.location == 2:
		player.set_position(door_obj.door_partner.position + Vector2(64, amount));
	if door_obj.location == 3:
		player.set_position(door_obj.door_partner.position + Vector2(-amount, 64));
	remove_child(current_room)
	current_room.remove_child(player)
	# Set new room as current room, and connect signals
	current_room = next_room
	current_room.connect("door_entered", self, "_on_player_transition", [], 1)
	# Move player to new room
	current_room.add_child(player)
	current_room.player_visited = true
	global_vars.current_room = current_room
	add_child(current_room)
	
	
func connect_room_signal():
	print("Connecting")
	
	
func start_game():#544 320
	get_node("main_menu_ui").get_node("AnimationPlayer").play("Fade_Out");

func spawn_player():
	add_child(current_room)
	current_room.player_visited = true
	player = current_room.get_node("Space_Ship/Player")
	current_room.connect("door_entered", self, "_on_player_transition", [], 1)
	remove_child(get_node("main_menu_ui"))
	global_vars.player = player
	global_vars.current_room = current_room
	

	

func exit_game():
	get_tree().quit()
