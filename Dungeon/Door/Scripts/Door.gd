extends Area2D

var locked_texture = load("res://Dungeon/Door/Sprites/Door_Locked.png")
var open_texture = load("res://Dungeon/Door/Sprites/Door_Open.png");
var state = "unlocked"
var connects_to;
var door_partner;
var location;
var is_partner = false

var requires = [] 

signal door_entered(door_obj)

func _ready():
	update_texture()

func rotate_90():
	rotation_degrees = 90
	$Status.set_rotation(-1.598);
	#position.x += 64

func initialize(partner, connects, location, is_p):
	self.door_partner = partner
	self.connects_to = connects
	self.location = location
	self.is_partner = is_p

func lock_door(requirement):
	requires.append(requirement)
	door_partner.requires.append(requirement)
	door_partner.update_texture()
	update_texture()
	
func unlock_door(requirement):
	if requirement in requires:
		requires.erase(requirement)
		door_partner.requires.erase(requirement)
		door_partner.update_texture()
		update_texture()
	else:
		"No requirement found in unlocking door"

func interact(player):
	if requires.size() == 0:
		print("Door interacted, sending signal to room")
		emit_signal("door_entered", self)
	else:
		print("Door interacted yet is locked")
		var found = false
		for item in player.inventory:
			if item.item_name in requires:
				player.remove_from_inventory(item)
				unlock_door(item.item_name)
				found = true
				$Status.appear("Unlocked!")
		if !found:
			$Status.appear("Locked, Requires " + requires[-1])
	update_texture()
	
func update_texture():
	if requires.size() > 0:
		state = "locked"
		$Sprite.texture = locked_texture
	else:
		state = "unlocked"
		$Sprite.texture = open_texture
