extends MarginContainer

var room_icon = load("res://UI/HUD/Sprites/minimap_room.png")
var door_locked_icon = load("res://UI/HUD/Sprites/minimap_room_green.png")
var door_unlocked_icon = load("res://UI/HUD/Sprites/minimap_room_red.png")
var room_node = load("res://UI/HUD/Minimap_Node.tscn")

var gv
var room_dict = {}
var room_spacing = 30

func _ready():
	gv = Game.Generator.get_node("Global_Vars");
	#var room_amount = gv.get_room_list_size()
	for room in gv.room_list:
		var room_minimap = room_node.instance()
		room_dict[room] = room_minimap
		var pos_x = room.x * room_spacing + 20
		var pos_y = room.y * room_spacing
		room_minimap.position = Vector2(pos_x, pos_y)
		$VBoxContainer/Grid.add_child(room_minimap)
		update_map()
	

func update_map():
	for room in room_dict:
		var room_minimap = room_dict[room]
		if room.player_visited == true:
			room_minimap.visible = true
		else:
			room_minimap.visible = false
		for door in room.door_children:
			room_minimap.toggle_lock_door(door.location, door.state)
	if gv.current_room != null:
		$VBoxContainer/Grid/player_marker.position = room_dict[gv.current_room].position


		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
