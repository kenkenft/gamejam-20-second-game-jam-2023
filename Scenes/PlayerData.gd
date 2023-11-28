extends Node2D

signal ShowDifferentMenu
signal UpdateResultScreen

var highScores = [0, 0, 0]
var idToName = {0: "Apple", 1: "Banana", 2: "Cherry", 3: "Durian", 4: "Egusi", 5: "Fig", 6: "Grapefruit"}
var selectedDifficulty = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TitleMenu_UpdateBasketVisibility(difficulty):
	selectedDifficulty = difficulty

func _on_MainGame_TimeUp(currentScore, highestMultiplier, longestCombo, mistakesCount, sortedFruits, multiplierLimits):
	
	emit_signal("ShowDifferentMenu", 2)
	
#	print("PlayerData area")
#	for i in range(0, sortedFruits.size()):
#		print("Sorted fruit {0}: {1}".format([i, idToName[sortedFruits[i]]]))
	emit_signal("UpdateResultScreen", [currentScore, longestCombo, highestMultiplier, mistakesCount, selectedDifficulty, multiplierLimits], sortedFruits)	
