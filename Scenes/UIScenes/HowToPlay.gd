extends Node2D

func _on_Controls_pressed():
	get_node("ColorRect/GameControls").visible = true
	get_node("ColorRect/Monsters").visible = false
	get_node("ColorRect/GameControls2").visible = false

func _on_MonsterGuide_pressed():
	get_node("ColorRect/Monsters").visible = true
	get_node("ColorRect/GameControls").visible = false
	get_node("ColorRect/GameControls2").visible = false

func _on_Build_pressed():
	get_node("ColorRect/GameControls").visible = false
	get_node("ColorRect/Monsters").visible = false
	get_node("ColorRect/GameControls2").visible = true

func _on_Back_pressed():
	queue_free()
	get_tree().change_scene_to(load("res://SceneHandler.tscn"))# Replace with function body.

