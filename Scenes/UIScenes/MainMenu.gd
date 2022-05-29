extends Control

func _ready():
	if GameData.map1_won == true:
		get_node("M/VB/NewGame/NewLabel").text = "NEXT LEVEL"
		get_node("B2").visible = true
	else:
		get_node("M/VB/NewGame/NewLabel").text = "New Game"
		get_node("B2").visible = false
