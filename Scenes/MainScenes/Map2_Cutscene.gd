extends Node2D

var warnings = [
"Hey rookie! How’s it going?",
"Still not over the fact that I’m dead...",
"Take your time, sooner or later you’ll get used to it. ",
"I don't know if this will make you feel any better...",
"but you’ve been doing an impressive work so far!",
"Oh no, I didn’t even do that much...",
"Kick this impostor sindrome back to earth where it belongs! You are a new free soul now!",
"Not everyone successfully coordinates an entire team in a soul outbreak at their first day dead.",
"You should be proud of yourself",
"Wow I don’t know what to say... Thank you",
"...",
"Hey can I ask a question?",
"Yup, bring it on",
"Why were those souls trying to cross the portal?",
"To get back to earth of course!",
"But why? I imagine they can't get their body and life back, right?",
"Yes you are correct, but you'd  be surprised about how stubborn and selfish some souls are...",
"(... What’s that supposed to mean?)",
"Lots of them insists on going back to earth despite knowing the consequences",
"Most humans can’t handle seeing ghosts, so they  try to escape hell just to scare people to death...",
"and also because they don't want to work to pay for their sins...",
"Let's just say they are fine with suffering for eternity but only if it's without moving a muscle",
"consequently they didn't take well the idea of working after death haha",
"that’s why we need to guard the portals at all costs...",
"Sorry I gotta go, get some rest and good luck on your next shift!"
]

var typing_speed = 0.05
var read_time = 2

var current_message = 0
var display = ""
var current_char = 0

func _ready():
	start_dialogue()
	

func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	
	$Background/Animations.play("Map_2_Cutscene")
	
	if $LevelMusic.playing ==false:
		$LevelMusic.play()
		
	$next_char.set_wait_time(typing_speed)
	$next_char.start()

func stop_dialogue():
	queue_free()
	get_tree().change_scene_to(load("res://SceneHandler.tscn"))
	#get_tree().change_scene_to(load("res://Scenes/MainScenes/GameScene.tscn"))
	
func _on_next_char_timeout():
	$Label.modulate =  Color(1, 1, 1)
	$Name.modulate =  Color(1, 1, 1)
	get_node("Name").text = "Hazel:"
					
	
	if warnings[current_message] == "Still not over the fact that I’m dead...":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
		
	elif warnings[current_message] == "Oh no, I didn’t even do that much...":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "Wow I don’t know what to say... Thank you":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "Hey can I ask a question?":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "Why were those souls trying to cross the portal?":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "But why? I imagine they can't get their body and life back, right?":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "(... What’s that supposed to mean?)":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	
	if (current_char < len(warnings[current_message])):
		var next_char = warnings[current_message][current_char]
		display += next_char
		
		$Label.text = display
		current_char += 1
	else:
		$next_char.stop()
		$next_message.one_shot = true
		$next_message.set_wait_time(read_time)
		$next_message.start()

func _on_next_message_timeout():
	if (current_message == len(warnings) - 1):
		stop_dialogue()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()

func _on_Skip_pressed():
	stop_dialogue()

