extends Node

var tracks = ["Dasein", "EndlessBlue"]

func play_music(music_name):
	var song = load("res://Audio/Music/" + music_name + ".ogg")
	$Music.stream = song
	$Music.play()

	

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
