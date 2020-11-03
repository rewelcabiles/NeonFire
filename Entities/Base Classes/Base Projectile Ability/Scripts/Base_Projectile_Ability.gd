extends Node2D

export (PackedScene) var projectile_class;

var can_fire = true
var reloading = false

export var weapon_name = "Default Name"
export var max_total_ammo = 100
export var total_ammo = 100 setget update_total
export var max_clip = 30 setget update_max
export var cur_clip = 30 setget update_cur
export var fire_rate = 0.5;
export var reload_time = 2.0;
export var ammo_pickup_multiplier = 1.0

signal property_change


func update_total(data):
	total_ammo = data
	emit_signal("property_change", self)

func update_max(data):
	max_clip = data
	emit_signal("property_change", self)
	
func update_cur(data):
	cur_clip = data
	emit_signal("property_change", self)
	
func reload():
	if total_ammo > 0 and !reloading and cur_clip != max_clip:
		self.reloading = true
		$reload_timer.set_wait_time(reload_time)
		$reload_timer.start();

func fire():
	if can_fire and cur_clip != 0 and !reloading:
		spawn_projectiles()
		can_fire = false
		self.cur_clip -= 1
		$fire_timer.set_wait_time(fire_rate)
		$fire_timer.start();

func spawn_projectiles():
	var projectile = projectile_class.instance();
	if not get_parent().name == "Player":
		projectile.is_player_bullet(false)
		
	projectile.transform = get_parent().get_node("Aim").global_transform;
	get_parent().get_parent().add_child(projectile)


func _on_fire_timer_timeout():
	can_fire = true


func _on_reload_timer_timeout():
	reloading = false
	var difference = max_clip - cur_clip
	if total_ammo >= difference:
		self.total_ammo -= difference
		self.cur_clip += difference
	else:
		self.cur_clip += total_ammo
		self.total_ammo = 0
