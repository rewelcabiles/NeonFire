extends Area2D

export var speed = 600
export var damage = 2
export (bool) var player_projectile = false
var watching = true

func _physics_process(delta):
	position += transform.x * (speed*10) * delta

func _on_Base_Projectile_body_shape_entered(body_id, body, body_shape, area_shape):
	if !watching:
		return null
	if body.name != "wall_tiles":
		body.take_damage(damage)

	speed = 20
	watching = false
	$hit_particle.emitting = true
	$AnimationPlayer.play("die")

func is_player_bullet(is_player):
	if !is_player:
		set_collision_layer_bit(3, false)
		set_collision_layer_bit(4, true)
		set_collision_mask_bit(2, false)
		set_collision_mask_bit(0, true)
