extends Node2D

var player;

var current_room;
var floor_1;
var floor_2;
var floor_3;
var global_vars
var door_mirror = {0:2, 1:3, 2:0, 3:1}
var door_obj


func _ready():
	Game.new_game()
	global_vars = Game.Generator.get_node("Global_Vars")
	floor_1 = Game.Generator.get_node("Eller").generate_floor(5, 0)
	var path = Game.Generator.get_node("DFS").do_dfs(floor_1)
	
	for room_index in range(path.size()):
		var c = path[room_index]
		c.room_index = room_index
		c.get_node("Label").text = "X: "+str(c.x) + " Y:" + str(c.y) + " RI:" + str(c.room_index)
		
	path = Game.Generator.get_node("Populator").populate_level(path)
	current_room = path[0]
	MusicManager.loop_mode = false
	MusicManager.playlist_mode = true
	MusicManager.play_music("Synthy")
	spawn_player()

func transition(door):
	door_obj = door
	$AudioStreamPlayer.play_door_opening()
	$Overlay/Control/TransitionShader/AnimationPlayer.play("fade_out")
	

	
func _on_player_transition():
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
	current_room.connect("door_entered", self, "transition", [], 1)
	# Move player to new room
	current_room.add_child(player)
	current_room.player_visited = true
	global_vars.current_room = current_room
	call_deferred("add_child", current_room)
	$Overlay/Control/TransitionShader/AnimationPlayer.play("fade_in")


func spawn_player():
	add_child(current_room)
	current_room.player_visited = true
	player = current_room.get_node("Space_Ship/Player")
	current_room.connect("door_entered", self, "transition", [], 1)
	player.connect("died", self, "player_died", [], 1)
	global_vars.player = player
	global_vars.current_room = current_room	

func transition_to_end_game():
	$Overlay/Control/TransitionShader/AnimationPlayer.play("end")

func end_game():
	current_room.call_deferred("queue_free")
	Game.clear_generator()

func player_died():
	print("Player died for some reason :thinking:")
	$AnimationPlayer.play("dead_screen")

func call_main_menu():
	get_parent().show_main_menu()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		_on_player_transition()
		
func _on_return_pressed():
	print("End game pressed")
	transition_to_end_game()
	$AnimationPlayer.play("fade_out")
