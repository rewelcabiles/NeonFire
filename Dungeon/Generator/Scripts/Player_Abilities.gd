extends Node

signal changed

var unlocked_abilities = {
	"shielded_dash" : false,
	"resource_up" : false,
	"unlock_map" : false
}

func unlocked_ability(ability_name):
	unlocked_abilities[ability_name] = true
	emit_signal("changed")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
