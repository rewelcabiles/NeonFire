extends Node

var invulnerable = false
var invulnerable_time = 0.2

export var max_hp = 20
export var cur_hp = 20
# starting out, 5 HP any form of damage removes 1 HP
# 0.5 to 1 second invuln timer after getting hit
# Shields


func take_damage(damage):
	if !invulnerable:
		get_parent().get_node("damage_particles").emitting = true
		cur_hp = cur_hp - damage;
		update_hud()
		invulnerable = true
		$invuln_timer.start(invulnerable_time)

func update_hud():
	get_parent().HUD.health.update_health(max_hp, cur_hp)

func _physics_process(delta):
	if invulnerable:
		get_parent().get_node("AnimationPlayer").play("damage_flash")

func _on_invuln_timer_timeout():
	invulnerable = false
