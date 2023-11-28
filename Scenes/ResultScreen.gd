extends Node2D

signal PlaySFX
signal UpdateHighScore
signal ShowDifferentMenu

export var DynamicText = []
export var Buttons = []
export(NodePath) var GameManager

var fruits = []
var finalScore = 0
var difficulty
var idToName = {0: "Apple", 1: "Banana", 2: "Cherry", 3: "Durian", 4: "Egusi", 5: "Fig", 6: "Grapefruit"}
#func _ready():
	#get_node(Buttons[0]).connect("")
#	# Set up node button references
	# emit_signal("ShowDifferentMenu", 2)

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
	print("_on_PlayerData_UpdateResultScreen()")
	for i in range(0, sortedFruits.size()):
		print("Sorted fruit {0}: {1}".format([i, idToName[fruits[i]]]))
		
	difficulty = resultData[4]
	PlaySong()
	get_node(DynamicText[0]).bbcode_text = "[b]{0} points[/b]".format([resultData[0]])
	get_node(DynamicText[1]).bbcode_text = "[b]{0}[/b]".format([resultData[1]])
	get_node(DynamicText[2]).bbcode_text = "[b]{0}[/b]".format([resultData[2]])
	get_node(DynamicText[3]).bbcode_text = "[b]{0}[/b]".format([resultData[3]])
	get_node(DynamicText[4]).bbcode_text = "[b]{0}[/b]".format([resultData[0]])
	#Store score against highscore emit_signal("UpdateHighScore", finalScore, difficulty)


func _on_PlaySong_pressed():
	PlaySong()


func _on_Replay_pressed():
	get_node(GameManager).SetUpGame(difficulty)


func _on_TitleScreen_pressed():
	emit_signal("ShowDifferentMenu", 0)
