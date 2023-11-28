extends Node2D

signal PlaySFX
signal UpdateHighScore
export var DynamicText = []

var fruits = []
var finalScore = 0

func SetUp():
	fruits.clear()


func PlaySong():
	for i in range(0,fruits.size()):
		if(i % 3 == 0):
			yield(get_tree().create_timer(0.5), "timeout")
		else:
			yield(get_tree().create_timer(0.2), "timeout")
		emit_signal("PlaySFX", fruits[i])


func _on_PlayerData_UpdateResultScreen(resultData, sortedFruits):
	SetUp()
	fruits = sortedFruits
	
	
	pass # Replace with function body.
