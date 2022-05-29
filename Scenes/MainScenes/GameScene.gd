extends Node2D

signal game_over(result)

var map_node

var build_mode = false
var build_valid = false
var build_title
var build_location 
var build_type

var cash = 0

var current_wave = 0
var enemies_in_wave = 0

var base_health = 100

var count = 0
var timer30

	
func _ready():
	load_map()
		
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", self, "initiate_build_mode",[i.get_name()])
	
	if $GameMusic.playing ==false:
		$GameMusic.play()
	
	###FrenzyTimer
	timer30 = get_node("30Seconds")
	timer30.set_wait_time( 30 )
	#timer30.connect("timeout", self, "_on_Timer_timeout")
	
func load_map():
	if GameData.map1_won == false:
		get_node("Map1").visible = true
		get_node("Map2").visible = false
		map_node = get_node("Map1") ##changes depending on the map
	else:
		get_node("Map2").visible = true
		get_node("Map1").visible = false
		map_node = get_node("Map2") ##changes depending on the map

func _process(_delta):
	if build_mode:
		update_tower_preview()

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

########################
##   Wave Functions   ##
########################

func start_next_wave():
	var wave_data = retrieve_wave_data()
	#yield(get_tree().create_timer(0.8),"timeout")##time between waves
	spawn_enemies(wave_data)

func retrieve_wave_data():
	
	if GameData.map1_won == false:
		var wave_data = GameData.wave_map1
		current_wave += 1
		enemies_in_wave = wave_data.size()
		return wave_data
	else:
		var wave_data = GameData.wave_map2
		current_wave += 1
		enemies_in_wave = wave_data.size()
		return wave_data


func spawn_enemies(wave_data):
	
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instance()
		new_enemy.connect("base_damage", self, 'on_base_damage')
		map_node.get_node("Path").add_child(new_enemy, true)
		count = count + 1
		$Timer.start(i[1]); yield($Timer, "timeout")
		
		if count == 105:
			get_node("UI/HUD/FrenzyWarning").visible = true
			frenzy_start()
			
		

############################
##      Frenzy Timer      ##
############################

func frenzy_start():
	timer30.start()
	$GameMusic.stop()
	$FrenzyMusic.play()

func _on_30Seconds_timeout():
	GameData.cash = 150
	
	if GameData.map1_won == false:
		GameData.map1_won = true
		$FrenzyMusic.stop()
		queue_free()
		get_tree().change_scene_to(load("res://Scenes/MainScenes/Map2_Cutscene.tscn"))
	else:
		$FrenzyMusic.stop()
		queue_free()
		get_tree().change_scene_to(load("res://Scenes/MainScenes/GameCompleted.tscn"))
	

############################
##   Building functions   ##
############################
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type + "T1"
	build_mode = true
	get_node("UI").set_tower_preview(build_type,get_global_mouse_position() )

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_title = map_node.get_node("TowerExclusion").world_to_map(mouse_position)
	var title_position = map_node.get_node("TowerExclusion").map_to_world(current_title)
	
	if map_node.get_node("TowerExclusion").get_cellv(current_title) == -1:
		get_node("UI").update_tower_preview(title_position,"ad54ff3c")
		build_valid = true
		build_location = title_position
		build_title = current_title
	else:
		get_node("UI").update_tower_preview(title_position,"adff4545")
		build_valid = false

func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").free()

func verify_and_build():
	var towerprice = GameData.towerdata[build_type]["price"]##ccheck if it's receiving the price
	var current_money = GameData.cash
	
	if build_valid and current_money >= towerprice:
		##test to verify player has enought G
		var new_tower = load("res://Scenes/Turrets/" + build_type + ".tscn").instance()
		new_tower.position = build_location
		new_tower.built = true
		new_tower.type = build_type
		new_tower.category = GameData.towerdata[build_type]["category"]
		map_node.get_node("Turrets").add_child(new_tower, true)
		map_node.get_node("TowerExclusion").set_cellv(build_title,5)
		##deduct cash
		var expenses = current_money - towerprice
		##update cash
		GameData.cash -= GameData.cash - expenses
	else:
		build_mode = false
		build_valid = false

func on_base_damage(damage):
	base_health -= damage
	if base_health <= 0:
		emit_signal("game_over", false)
	else:
		get_node("UI").update_health_bar(base_health)









