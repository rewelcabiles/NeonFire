extends "res://Entities/Base Classes/Base Projectile Ability/Scripts/Base_Projectile_Ability.gd"

var speed = 0

func fire():
	.fire()
	if cur_clip == 0:
		$reload_reminder.text = "Reload!"

func toggle_ground_item(t):
	if t == true:
		$floor_item.visible = true
		$floor_item.monitorable = true
	else:
		$floor_item.visible = false
		$floor_item.monitorable = false

func _physics_process(delta):
	position += transform.x * speed * delta
	if speed > 0:
		$floor_item/weapon_name.visible = false
		speed -= 10
	if speed == 0:
		rotation = 0
		$floor_item/weapon_name.visible = true

func drop():
	var room = get_parent().get_parent()
	self.transform = get_parent().transform
	self.rotation = get_parent().get_node("Aim").rotation
	get_parent().remove_child(self)
	room.add_child(self)
	toggle_ground_item(true)
	speed = 300

func reload():
	.reload()

func _on_reload_timer_timeout():
	._on_reload_timer_timeout()
	$reload_reminder.text = ""

func _on_Base_Player_Projectile_weapon_tree_entered():
	if get_parent().name != "Player":
		toggle_ground_item(true)
	else:
		toggle_ground_item(false)
