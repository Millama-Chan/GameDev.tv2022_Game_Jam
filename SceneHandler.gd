extends Node

func _ready():
	load_main_menu()

func load_main_menu():
	get_node("MainMenu/M/VB/NewGame").connect("pressed", self,"on_new_game_pressed")
	get_node("MainMenu/M/VB/Quit").connect("pressed", self,"on_quit_pressed")
	get_node("MainMenu/M/VB/HowToPlay").connect("pressed", self,"on_HowToPlay_pressed")
	get_node("MainMenu/M/VB/Credits").connect("pressed", self,"on_credits_pressed")
	
func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/GameScene.tscn").instance()
	game_scene.connect("game_over", self, 'unload_game')
	add_child(game_scene)

func on_HowToPlay_pressed():
	get_node("MainMenu").queue_free()
	var howtoplay = load("res://Scenes/UIScenes/HowToPlay.tscn").instance()
	add_child(howtoplay)

func on_quit_pressed():
	get_tree().quit()

func on_credits_pressed():
	get_node("MainMenu").queue_free()
	var credits = load("res://Scenes/UIScenes/Credits.tscn").instance()
	add_child(credits)

func unload_game(_result):
	get_node("GameScene").queue_free()
	GameData.cash = 150
	GameData.map1_won = false
	var main_menu = load("res://Scenes/UIScenes/MainMenu.tscn").instance()
	var gameover = load("res://Scenes/UIScenes/GameOverScreen.tscn").instance()
	add_child(main_menu)
	add_child(gameover)
	load_main_menu()
