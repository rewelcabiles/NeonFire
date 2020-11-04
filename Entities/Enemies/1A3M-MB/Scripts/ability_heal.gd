extends Node2D

var time_elapsed = 0.0
var enabled = false
export (float) var healing_amount = 0.15
export (float) var duration = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func start():
	$ability_heal_timer.start(1)
	
func stop():
	$ability_heal_timer.stop()

func _on_ability_heal_timer_timeout():
	time_elapsed += 1
	if time_elapsed >= duration:
		stop()
	var amount = get_parent().max_health * healing_amount / duration
	get_parent().heal(amount)
