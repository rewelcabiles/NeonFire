extends "res://Entities/Enemies/BaseEnemy/Scripts/Base Enemy.gd"

signal shield_died
var last_damage_taken

func take_damage(damage, from = null):
	var new_modulate = Color(1.4, health / max_health, 1.4, 1)
	var old_modulate = $Aim.modulate
	last_damage_taken = damage
	$Tween.interpolate_property($Aim, "modulate", old_modulate, new_modulate, 0.5)
	$Tween.start()
	print("ENEMY OFF 1")
	.take_damage(damage, from)

func _on_ability_shield_shield_died():
	emit_signal("shield_died")
