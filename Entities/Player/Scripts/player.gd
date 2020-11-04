extends KinematicBody2D

export (int) var base_speed = 440
export (bool) var input_possible = false
export (int) var energy_warp = 50
var speed = base_speed
var acceleration = 0.2



var velocity = Vector2()
var interactable = [];
var inventory = [];

onready var HUD = $HUD

func _ready():
	HUD.player = self
	
func take_damage(damage, p_owner):
	$health.take_damage(damage, p_owner)

func add_to_inventory(item):
	inventory.append(item)
	item.get_parent().remove_child(item)
	HUD.inventory.update_items(inventory)

func remove_from_inventory(item):
	inventory.erase(item)
	HUD.inventory.update_items(inventory)

func get_input():
	var input_velocity = Vector2.ZERO
	if Input.is_action_pressed("primary_action"):
		$weapons.use_weapon()
		
	if Input.is_action_just_pressed("switch_weapon"):
		$weapons.switch_weapons()
	
	if Input.is_action_just_pressed("reload"):
		$weapons.reload_weapon()
	
	if Input.is_action_just_pressed("interact"):
		if interactable.size() != 0:
			interactable[-1].interact(self)
	if Input.is_action_just_pressed("dash"):
		$dash.dash()
			
	if Input.is_action_pressed('move_right'):
		input_velocity.x += 1
	if Input.is_action_pressed('move_left'):
		input_velocity.x -= 1
	if Input.is_action_pressed('move_down'):
		input_velocity.y += 1
	if Input.is_action_pressed('move_up'):
		input_velocity.y -= 1
		
	input_velocity = input_velocity.normalized() * speed
	
	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, acceleration)

func _physics_process(delta):
	if input_possible:
		get_input()
	$Aim.look_at(get_global_mouse_position())
	velocity = move_and_slide(velocity)
	

func _on_interact_zone_area_entered(area):
	if area.is_in_group("interactable"):
		interactable.append(area)


func _on_interact_zone_area_exited(area):
	if area.is_in_group("interactable") and interactable.has(area):
		interactable.erase(area)



