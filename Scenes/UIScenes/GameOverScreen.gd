extends CanvasLayer

var warnings = [
	"...",
	"Here I was thinking this time it would be different...",
	"(This time? But I don't recall dying before)",
	"How am I supposed to explain to my superiors that more than half of the earth went insane and perished?",
	"Humf screw the rules, I'll just use my powers to fix this",
	"And make sure you do your job right on your next death",
	"W-WHAT? You can't send be back to earth, I thought that was forbidden!",
	"Oh, it is... for me and most souls at least",
	"But not for my coleagues from the resurrection departament",
	"(...but I was just getting used to being dead...)",
	"I'll see you on your next death",
	"...",
]

var typing_speed = 0.08
var read_time = 2

var current_message = 0
var display = ""
var current_char = 0

func _ready():
	$AnimationPlayer.play("GameOver")
	start_dialogue()
	

func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	
	#$Background/AnimationPlayer.play("BossAppear")
	
	if $GameOverMusic.playing ==false:
		$GameOverMusic.play()
		
	$next_char.set_wait_time(typing_speed)
	$next_char.start()

func stop_dialogue():
	queue_free()
	get_tree().change_scene_to(load("res://SceneHandler.tscn"))
	
func _on_next_char_timeout():
	$Label.modulate =  Color(1, 1, 1)
	$Name.modulate =  Color(1, 1, 1)
	get_node("Name").text = " Hazel:"
	
	if warnings[current_message] == "(This time? But I don't recall dying before)":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "W-WHAT? You can't send be back to earth, I thought that was forbidden!":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "(...but I was just getting used to being dead...)":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "...":
		$Label.modulate =  Color(0, 1, 0)
		$Name.modulate  =  Color(0, 1, 0)
		get_node("Name").text = "Player:"
	elif warnings[current_message] == "I'll see you on your next death":
		get_node("Skip").visible = false

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
