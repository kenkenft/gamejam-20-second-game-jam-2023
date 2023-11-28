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

# resultData = [currentScore, longestCombo, highestMultiplier, 
#				mistakesCount, selectedDifficulty, multiplierLimits]
func _on_PlayerData_UpdateResultScreen(resultData, sortedFruits):
	SetUp()
	fruits = sortedFruits
	get_node(DynamicText[0]).bbcode_text = "[b]{0} points[/b]".format([resultData[0]])
	get_node(DynamicText[1]).bbcode_text = "[b]{0}[/b]".format([resultData[1]])
	get_node(DynamicText[2]).bbcode_text = "[b]{0}[/b]".format([resultData[2]])
	get_node(DynamicText[3]).bbcode_text = "[b]{0}[/b]".format([resultData[3]])
	get_node(DynamicText[4]).bbcode_text = "[b]{0}[/b]".format([resultData[0]])
	pass # Replace with function body.
