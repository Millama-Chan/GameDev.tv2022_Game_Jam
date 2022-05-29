extends Node2D

onready var timer = get_node("Timer")

func _ready():
	timer.set_wait_time(12)
	timer.start()
	logos()

func logos():
	
	if $StartAudio.playing ==false:
		$StartAudio.play()
	
	$AnimationPlayer.play("Logo1_fade_in")
	
func _on_Timer_timeout():
	stop_intro()

func stop_intro():
	queue_free()
	get_tree().change_scene_to(load('res://Scenes/MainScenes/NewGameIntro.tscn'))

