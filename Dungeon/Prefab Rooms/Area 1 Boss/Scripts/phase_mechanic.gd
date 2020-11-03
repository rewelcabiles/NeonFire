extends Node

onready var boss = get_parent().get_node("Boss")

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Boss_took_damage(boss):
	if boss.get_health_as_percentage() < 60:
		print(boss.get_health_as_percentage())
		print("ow")
		boss.get_node("AI").current_phase = 2
