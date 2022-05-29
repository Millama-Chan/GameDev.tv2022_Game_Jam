extends Node2D

var warnings = [
	"Is this it?", 
	"Did I...Die?",
	"Finally... I shall have some rest...",
	"SIKE!",
	"!!!",
	"Hey how was the trip friend? ",
	"W-what?",
	"Silly human, death is  only the beginning",
	"Sorry, but we are kinda in a rush here so we need to get you to work as soon as possible",
	"Huh? I need to work in heaven even after dead?",
	"... what makes you think you are in heaven?",
	"...",
	"(well, that's awkward)",
	"Don't worry your good doings weren't for nothing, you've been assigned one of the best jobs you could have here... hihi",
	"(... I guess I don't have that much of a choice...)",
	"Congratulations! You are our newest DEFENSE STRATEGIST",
	"Your work consists on making plans and devise strategies to help us capture run away souls around our various portals here on the underworld",
	"Although originally it should be only one portal...",
	"You can blame that on the troublemakers that makes us open portals at random locations to receive the deceased",
	"Anyway enough talking, I can already sense your soul is getting bored",
	"Just follow me and you'll probably understand better once we get there",
	"Oh and I'm Hazel by the way, your new hell of a boss!"
]

var typing_speed = 0.08
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
	
	$Background/AnimationPlayer.play("BossAppear")
	
	if $MusicBox.playing ==false:
		$MusicBox.play()
		
	$next_char.set_wait_time(typing_speed)
	$next_char.start()

func stop_dialogue():
	queue_free()
	get_tree().change_scene_to(load("res://SceneHandler.tscn"))
	
func _on_next_char_timeout():
	$Label.modulate =  Color(1, 1, 1)
	$Name.modulate =  Color(1, 1, 1)
	get_node("Name").text = " ? :"
	
	if warnings[current_message] == "Is this it?":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
		
	elif warnings[current_message] == "Did I...Die?":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "Finally... I shall have some rest...":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "SIKE!":
		$Label.modulate =  Color(1, 1, 1)
		$Name.modulate  =  Color(1, 1, 1)
		get_node("Name").text = " ? :"
		$MusicBox.stop()
		$LevelMusic.play()
	elif warnings[current_message] == "W-what?":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "Huh? I need to work in heaven even after dead?":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "(well, that's awkward)":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "(... I guess I don't have that much of a choice...)":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	
	if warnings[current_message] == "Oh and I'm Hazel by the way, your new hell of a boss!":
		get_node("Name").text = "Hazel:"
	
	
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
