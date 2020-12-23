extends RayCast2D

export var damage = 2
export var tick_per_damage = 0.2
export var ability_delay = 5
export var aim_delay = 5
export var fire_delay = 1

var is_casting := false setget set_is_casting
var state = 0 #0 = Off, 1 = Aiming, 2 = Firing, 3 between aiming and firing
var on = false
var can_damage = true
var body

func increase_difficulty():
	if ability_delay != 1:
		ability_delay -= 1
	if aim_delay != 1:
		aim_delay -= 1
	if fire_delay != 0.1:
		fire_delay -= 0.3

func _physics_process(delta):
	var cast_point := cast_to
	
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		body = get_collider()
		if state == 2:
			if body.name == "Player" and can_damage:
				body.take_damage(damage, get_parent())
				can_damage = false
				$damage_tick.start(tick_per_damage)
	
	if state == 1:
		self.transform = get_parent().get_node("Aim").transform
		
	if state == 2:
		$collision_particles.emitting = true
		$collision_particles.global_rotation = get_collision_normal().angle()
		$collision_particles.position = cast_point
		$beam_particles.emitting = true
	else:
		$collision_particles.emitting = false
		$beam_particles.emitting = false
		
	$Line2D.points[1] = cast_point
	$beam_particles.position = cast_point * 0.5
	$beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5

func set_is_casting(cast: bool):
	is_casting = cast
	
	if is_casting:
		appear(1)
	else:
		disappear()
		
	set_physics_process(is_casting)
	
func appear(state):
	$Tween.stop_all()
	if state == 1:
		$Tween.interpolate_property($Line2D, "width", 0, 5.0, 0.5)
	if state == 2:
		$Tween.interpolate_property($Line2D, "width", 5.0, 40.0, 0.2)
	$Tween.start()
	
func disappear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 40.0, 0, 0.5)
	$Tween.start()


func start():
	on = true
	$ability_delay.start(ability_delay)

func _on_ability_delay_timeout():
	state = 1
	self.is_casting = true
	$aim_delay.start(aim_delay)

func _on_aim_delay_timeout():
	state = 3
	$fire_delay.start(fire_delay)

func _on_fire_delay_timeout():
	state = 2
	appear(2)
	$fire_particles.emitting = true
	$fire_length.start(3)

func _on_fire_length_timeout():
	state = 0
	disappear()
	$fire_particles.emitting = false
	on = false


func _on_damage_tick_timeout():
	can_damage = true
