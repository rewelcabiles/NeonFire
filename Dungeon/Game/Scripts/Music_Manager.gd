extends Node

var tracks = ["Bright_Future_Ahead", "Aerial", "Synthwave_E", "Synthy"]
var track_iter = 0
var queued_song
var playlist_mode = false
var loop_mode = true
var last_played_song 

func load_song(song_name):
	var song = load("res://Audio/Music/" + song_name + ".ogg")
	last_played_song = song_name
	$Music.stream = song

func play_music(music_name):
	if music_name == "random":
		var random_song
		while true:
			random_song = tracks[randi() % tracks.size()]
			if random_song == last_played_song:
				continue
			else:
				break
		load_song(random_song)
		$Music.play()
		return
	if $Music.playing:
		$AnimationPlayer.play("fade_out")
		queued_song = music_name
	else:
		load_song(music_name)
		$Music.play()

func _ready():
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(_anim_name):
	$Music.volume_db = -20
	load_song(queued_song)
	$Music.play()


func _on_Music_finished():
	print("Music Done")
	var random_song
	while true:
		random_song = tracks[randi() % tracks.size()]
		print(random_song)
		print(last_played_song)
		if random_song == last_played_song:
			continue
		else:
			break
	play_music(random_song)
