extends Node2D

var door_class = load("res://Dungeon/Door/Door.tscn");

signal door_entered(door_obj)

var rng = RandomNumberGenerator.new()

export var is_prefab = false
export var cur_size = Vector2(0, 0)
export var min_size = Vector2(20, 20)
export var max_size = Vector2(20, 20)
var flags = []
var room_set;
var room_index
var visited = 0;
var player_visited = false
var x;
var y;
var door_pos = []
var connections = []
var door_children = []
var door_mirror = {0:2, 1:3, 2:0, 3:1}

func _ready():
	for door in door_children:
		door.connect("door_entered", self, "player_entered_door", [], 1)

func randomize_room():
	rng.randomize()
	if rng.randi_range(0, 100) < 30:
		cur_size.x = rng.randi_range(min_size.x, max_size.x)
		cur_size.y = rng.randi_range(min_size.y, max_size.y)
	else:
		cur_size.y = rng.randi_range(min_size.y, max_size.y)
		cur_size.x = rng.randi_range(min_size.x, max_size.x)

	for x in range(cur_size.x):
		for y in range(cur_size.y):
			if x == 0 or x == cur_size.x - 1 or y == 0 or y == cur_size.y - 1:
				$wall_tiles.set_cellv(Vector2(x, y), 1)
			else:
				$grid_tiles.set_cellv(Vector2(x, y), 5)
				$spawnable_tiles.set_cellv(Vector2(x, y), 5)
			$floor_tiles.set_cellv(Vector2(x, y), 3)
			
	$floor_tiles.update_bitmask_region()
	$wall_tiles.update_bitmask_region()
	$grid_tiles.update_bitmask_region()
	
	

func links_door(cell, dir):
	self.connections.append([cell, dir, 1])
	cell.connections.append([self, door_mirror[dir], 0])

func player_entered_door(door_obj):
	emit_signal("door_entered", door_obj)

func create_door_pos():
	rng.randomize()
	var north_door = Vector2(rng.randi_range(3, cur_size.x - 3), 0)
	var south_door = Vector2(rng.randi_range(3, cur_size.x - 3), cur_size.y)
	var east_door = Vector2(cur_size.x, rng.randi_range(3, cur_size.y - 3))
	var west_door = Vector2(0, rng.randi_range(3, cur_size.y - 3))
	door_pos = [north_door, east_door, south_door, west_door]
	
func connect_doors():
	rng.randomize()
	#create_door_pos()
	for partner in self.connections:
		var partner_cell = partner[0]
		var partner_dir = partner[1]
		if partner[2] == 1:
			continue
			
		var self_door = door_class.instance()
		var partner_door = door_class.instance()
		
		door_children.append(self_door)
		partner[0].door_children.append(partner_door)
		
		self_door.initialize(partner_door, partner[0], door_mirror[partner[1]], false)
		partner_door.initialize(self_door, self, partner[1], true)
		
		partner_door.connect("door_entered", partner_door.connects_to, "player_entered_door", [], 1)

		partner_door.set_position(Vector2($wall_tiles.map_to_world(partner_cell.door_pos[partner_dir])))
		self_door.set_position(Vector2($wall_tiles.map_to_world(door_pos[door_mirror[partner_dir]])))
		
		if partner_dir in [1, 3]:
			partner_door.position += Vector2(0, 0)
			self_door.position += Vector2(64,0)
			partner_door.rotate_90()
			self_door.rotate_90()			
		else:
			self_door.position += Vector2(0, -64)
			
		partner[0].add_child(partner_door)
		add_child(self_door)



func _on_Room_tree_entered():
	for flag in flags:
		$debug_flags.text += flag + ", "
	$Label.text = "X: "+str(x) + " Y:" + str(y) + " RI:" + str(room_index)
