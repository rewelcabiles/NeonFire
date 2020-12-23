extends KinematicBody2D

signal died
signal took_damage


export (float) var health = 10.0
export (float) var max_health = 10.0
export (int) var speed = 100
export (int) var difficulty = 1
export (bool) var looks_at_enemy = true

var velocity = Vector2()
var target = null
var ready = false


func _ready():
	ready = true

func _process(_delta):
	if ready:
		$AI.AI()
		
func _physics_process(delta):
	if !ready:
		return
	if get_parent().has_node("Player"):
		if !get_parent().get_node("Player").dead:
			target = get_parent().get_node("Player")
			if looks_at_enemy:
				$Aim.look_at(target.position)
		else:
			target = null
		
		
	else:
		target = null
	
	move_and_slide(velocity * speed)
	#print(velocity)

func heal(amount, bypass_max = false):
	health += amount
	if !bypass_max:
		if health + amount > max_health:
			health = max_health

func die():
	ready = false
	emit_signal("died", self)
	$death_particles.emitting = true
	$AnimationPlayer.play("die")

func take_damage(damage, from = null):
	health -= damage
	$damage_particles.emitting = true
	if health <= 0 and ready == true:
		die()
	else:
		emit_signal("took_damage", self)
	
func get_health_as_percentage():
	return (health / max_health) * 100.0



