extends Node2D

signal ShowDifferentMenu
signal UpdateResultScreen
signal ShowHighScores
signal IndicateNewestHighScore

var highScores = [0, 0, 0]
var idToName = {0: "Apple", 1: "Banana", 2: "Cherry", 3: "Durian", 4: "Egusi", 5: "Fig", 6: "Grapefruit"}
var selectedDifficulty = 0

func _on_TitleMenu_UpdateBasketVisibility(difficulty):
	selectedDifficulty = difficulty

func _on_MainGame_TimeUp(currentScore, highestMultiplier, longestCombo, mistakesCount, sortedFruits, multiplierLimits):
	
	emit_signal("ShowDifferentMenu", 2)
	
#	print("PlayerData area")
#	for i in range(0, sortedFruits.size()):
#		print("Sorted fruit {0}: {1}".format([i, idToName[sortedFruits[i]]]))
	emit_signal("UpdateResultScreen", [currentScore, longestCombo, highestMultiplier, mistakesCount, selectedDifficulty, multiplierLimits], sortedFruits)	


func _on_ResultScreen_UpdateHighScore(newScore, difficulty):
	if(newScore > highScores[difficulty]):
		highScores[difficulty] = newScore
		emit_signal("IndicateNewestHighScore")


func _on_TitleMenu_GetHighScores():
	emit_signal("ShowHighScores", highScores)
