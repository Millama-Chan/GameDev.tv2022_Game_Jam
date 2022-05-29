extends Node2D

func _ready():
	if $MusicBox.playing ==false:
		$MusicBox.play()


func _on_Audio_pressed():
	get_node("ColorRect/AudioInfo").visible = true
	get_node("ColorRect/ArtInfo").visible = false
	get_node("ColorRect/Story_Code").visible = false

func _on_Art_pressed():
	get_node("ColorRect/AudioInfo").visible = false
	get_node("ColorRect/ArtInfo").visible = true
	get_node("ColorRect/Story_Code").visible = false


func _on_ScriptCode_pressed():
	get_node("ColorRect/AudioInfo").visible = false
	get_node("ColorRect/ArtInfo").visible = false
	get_node("ColorRect/Story_Code").visible = true

func _on_Back_pressed():
	queue_free()
	get_tree().change_scene_to(load("res://SceneHandler.tscn"))# Replace with function body.
