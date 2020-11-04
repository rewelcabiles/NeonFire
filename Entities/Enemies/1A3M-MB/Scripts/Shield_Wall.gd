extends KinematicBody2D

signal died
signal took_damage

var health = 40.0
var max_health = 40.0
var ready = false
var current_width = 5

func _ready():
	ready = true
	connect("died", get_parent(), "shield_died")
	get_parent().connect("toggle_shields", self, "toggle_collision")
	$Tween.interpolate_property($Line2D, "width", 0, 5.0, 1)
	$Tween.start()

func take_damage(damage, damage_owner):
	if damage_owner.energy_warp == 0:
		return
	health -= damage
	damage_owner.energy_warp -= 1
	current_width = health / max_health * 5.0
	var old_width = $Line2D.width
	$Tween.interpolate_property($Line2D, "width", old_width, current_width, 0.2)
	$Tween.start()
	$hit_particles.emitting = true
	if health <= 0 and ready == true:
		ready = false
		emit_signal("died", self)
		$Tween.stop_all()
		$Tween.interpolate_property($Line2D, "width", current_width, 0, 0.2)
		$Tween.start()
	emit_signal("took_damage", self)

func toggle_collision(state):
	if state == true:
		$CollisionShape2D.set_deferred("disabled", false)
	elif state == false:
		$CollisionShape2D.set_deferred("disabled", true)

func _on_Tween_tween_completed(object, key):
	if ready == false:
		queue_free()
