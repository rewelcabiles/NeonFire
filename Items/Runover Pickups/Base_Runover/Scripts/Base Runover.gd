extends Area2D

var speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_run_over(player):
	print("Override _on_run_over function please")


func _on_Base_Runover_body_entered(body):
	if body.name == "Player":
		_on_run_over(body)
	
func _process(delta):
	position += transform.x * speed * delta
	if speed > 0:
		speed -= 10
