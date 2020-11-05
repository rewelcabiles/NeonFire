extends Node2D

signal shield_died
signal toggle_shields
var enabled = false

func _ready():
	visible = false
	toggle_shields(true)

func _physics_process(delta):
	if self.rotation_degrees == 0 or self.rotation_degrees == 360:
		self.rotating()
	
func rotating():
	$Tween.stop_all()
	$Tween.interpolate_property(self, "rotation_degrees", 0, 360, 60.0)
	$Tween.start()

func shield_died(shield):
	emit_signal("shield_died")
	print("shield has died")

func toggle_shields(state):
	print("Toggling Shields")
	print(state)
	enabled = state
	visible = state
	emit_signal("toggle_shields", state)
