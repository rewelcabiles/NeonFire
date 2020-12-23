extends Node

var Generator setget , get_generator
var time_start
var time_end

func get_generator():
	if Generator == null:
		Generator = load("res://Dungeon/Generator/Generator.tscn").instance()
	
	return Generator

func new_game():
	if Generator != null:
		Generator.call_deferred("queue_free")
	Generator = load("res://Dungeon/Generator/Generator.tscn").instance()
	time_start = OS.get_unix_time()

func clear_generator():
	Generator.call_deferred("queue_free")

func create_high_scores():
	var d = Directory.new()
	if !(d.dir_exists("user://highscores")):
		d.open("user://")
		d.make_dir("user://highscores")
	# Data
	time_end = OS.get_unix_time()
	var elapsed_time = time_end - time_start
	# Save
	var date = OS.get_datetime()
	var file_name = String(date["year"]) + "_" + String(date["month"]) + "_" + String(date["day"]) + "_" + String(date["hour"])+ "_" + String(date["minute"])
	var high_score = File.new()
	high_score.open("user://highscores/"+ file_name +".highscore", File.WRITE)
	high_score.store_line(String(elapsed_time))
	var date_string = String(date["year"]) + "/" + String(date["month"]) + "/" + String(date["day"]) + " " + String(date["hour"])+ ":" + String(date["minute"])
	high_score.store_line(date_string)
	high_score.close()
