extends Node2D

signal PlaySFX

var selectedDifficulty = 0
var highScores = [0, 0, 0]
var idToName = {0: "Apple", 1: "Banana", 2: "Cherry", 3: "Durian", 4: "Egusi", 5: "Fig", 6: "Grapefruit"}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_MainGame_TimeUp(currentScore, highestMultiplier, longestCombo, mistakesCount, sortedFruits):
	print("Final score: " + str(currentScore))
	print("Highest multiplier: " + str(highestMultiplier))
	print("Highest combo: " + str(longestCombo))
	print("Mistakes made:" + str(mistakesCount))
	for i in range(0,sortedFruits.size()):
		print("Item " + str(i) + idToName[sortedFruits[i]])
		if(i % 3 == 0):
			yield(get_tree().create_timer(0.5), "timeout")
		else:
			yield(get_tree().create_timer(0.2), "timeout")
		emit_signal("PlaySFX", sortedFruits[i])
