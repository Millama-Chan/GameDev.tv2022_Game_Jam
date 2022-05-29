extends Node2D

var warnings = [
	"You did it! Another portal was successfuly secured",
	"Everyone is happy with your performance",
	"Days goes by and you continue to use your strategy abilities to protect the portals",
	"and little by little...",
	"having to work after dead stopped being that boring",
	"especially with all of the friends you got to make along the days",
	"Something recomforting because you know  that even if you fail in the future...",
	"the cicle will repeat over and over again...",
	"and that means you will also always find your friends again",
	"CONGRATULATIONS YOU WON THE GAME!",
	"If you find any bugs or spelling errors, please feel free to send me a message",
	"Thank you for playing! I hope you enjoyed and had a good time!",
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
	
	
	if $MusicBox.playing ==false:
		$MusicBox.play()
		
	$next_char.set_wait_time(typing_speed)
	$next_char.start()

func stop_dialogue():
	GameData.map1_won = false
	queue_free()
	get_tree().change_scene_to(load("res://SceneHandler.tscn"))

	
func _on_next_char_timeout():
	
	if warnings[current_message] == "especially with all of the friends you got to make along the days":
		get_node("Background/Boss_SmileTalk").visible = true
		get_node("Background/Friend_F1").visible = true
		get_node("Background/Friend_M1").visible = true
	elif warnings[current_message] == "CONGRATULATIONS YOU WON THE GAME!":
		get_node("Background/Boss_SmileTalk").visible = false
		get_node("Background/Friend_F1").visible = false
		get_node("Background/Friend_M1").visible = false
		$Label.modulate =  Color(1, 0, 1)
	elif warnings[current_message] == "If you find any bugs or spelling errors, please feel free to send me a message":
		$Label.modulate =  Color(1, 0, 1)
	elif warnings[current_message] == "Thank you for playing! I hope you enjoyed and had a good time!":
		$Label.modulate =  Color(1, 0, 1)

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
