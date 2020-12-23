extends Node

var invulnerable = false
var invulnerable_time = 0.05

export var max_hp = 20
export var cur_hp = 20
# 0.5 to 1 second invuln timer after getting hit
# Shields

func take_damage(damage, _p_owner):
	if !invulnerable:
		cur_hp = cur_hp - damage;
		update_hud()
		invulnerable = true
		if cur_hp <= 0:
			get_parent().get_node("AnimationPlayer").stop()
			get_parent().get_node("AnimationPlayer").play("died")
			get_parent().input_possible = false
			get_parent().velocity = Vector2(0, 0)
			get_parent().HUD.get_node("AnimationPlayer").play("Fade_Out")
			get_parent().dead = true
			get_parent().emit_signal("died")
			
			
		get_parent().get_node("damage_particles").emitting = true
		
		$invuln_timer.start(invulnerable_time)

func update_hud():
	get_parent().HUD.health.update_health(max_hp, cur_hp)

func _physics_process(_delta):
	if invulnerable:
		get_parent().get_node("AnimationPlayer").play("damage_flash")

func _on_invuln_timer_timeout():
	invulnerable = false
