extends Node2D

var new_game_class = load("res://Dungeon/Game/playing.tscn")

func _ready():
	MusicManager.play_music("Bright_Future_Ahead")

	
func start_game():
	get_node("main_menu_ui").get_node("AnimationPlayer").play("Fade_Out");
	var new_game = new_game_class.instance()
	add_child(new_game)
	
func show_main_menu():
	get_node("main_menu_ui").get_node("AnimationPlayer").play("Fade_In");
	$Camera2D.current = true

func get_high_scores():
	var high_score_class = load("res://Dungeon/Game/Assets/high_score.tscn")
	var files = []
	var dir = Directory.new()
	dir.open("user://highscores")
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.ends_with("highscore"):
			files.append(file)
	dir.list_dir_end()

	for file in files:
		print(file)
		var high_score = File.new()
		high_score.open("user://highscores/"+ file, File.READ)
		var elapsed = high_score.get_line()
		var date = high_score.get_line()
		high_score.close()
		print(elapsed)
		print(date)
		var new_score = high_score_class.instance()
		new_score.get_node("Elapsed Time").text = elapsed
		new_score.get_node("Date").text = date
		$high_scores/VBoxContainer.add_child(new_score)
		

func exit_game():
	get_tree().quit()

func _on_button_option_pressed():
	get_high_scores()
	$main_menu_ui.get_node("AnimationPlayer").play("Fade_Out");
	$high_scores.get_node("AnimationPlayer").play("fade_in")

func _on_button_menu_pressed():
	$main_menu_ui.get_node("AnimationPlayer").play("Fade_In");
	$high_scores.get_node("AnimationPlayer").play("fade_out")
