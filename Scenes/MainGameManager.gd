extends Node2D

signal PlaySFX
signal TimeUp
signal ShowCrateByDifficulty

var acceptedInputActions = ["gameplay_sort_easy_v3", "gameplay_sort_medium_v3", "gameplay_sort_hard_v3"] # WASD and IJKL scheme. 
var inputToFruitId = {KEY_L: 0, KEY_A: 1, KEY_D: 2, KEY_W: 3, KEY_I: 4, KEY_SPACE: 5, KEY_J: 6 }# WASD and IJKL scheme.

# Note: the numbers in the arrays correspond to the fruit ids, and are not the proper notation for chord degrees. Assume C Major scale
var chordProgressions = [
	[2, 5, 6],	# Chords I IV V
	[2, 4, 6],	# Chords I ii V
	[2, 4, 5],	# Chords I iii IV
	[2, 3, 4],	# Chords I ii iii
	[4, 5, 6],	# Chords ii iii vii
	[4, 6, 1],	# Chords ii IV vii
	[2, 0, 1]	# Chords I vi vii
]

var multiplierLimits = [4, 8, 12]
var allowedFruits = [3, 5, 7]
var allowedChordProgressionRange = [1, 5, 7]
var selectedDifficulty = 1

var CurrentFruitObject
var isPlaying = false
var isCheckingInput = false
var random = RandomNumberGenerator.new()

var idToName = {0: "Apple", 1: "Banana", 2: "Cherry", 3: "Durian", 4: "Egusi", 5: "Fig", 6: "Grapefruit"}

var playerUI

var currentScore = 0
var currentMultiplier = 1
var highestMultiplier = 1
var multiplierMax
var currentTimer
var mistakesCount = 0
var currentCombo = 0
var longestCombo = 0
var currentChordSet
var currentChordInSet = 0

var sortedFruits = []

func _input(event):
	if (isPlaying && !isCheckingInput && event.is_action_pressed(acceptedInputActions[selectedDifficulty])):
		isCheckingInput = true
		CompareKeyToFruit(event.scancode)
		#yield(get_tree().create_timer(0.10), "timeout")
		isCheckingInput = false

func SetUp():
	emit_signal("ShowCrateByDifficulty", selectedDifficulty)
	GetNodesRefs()
	ResetValues()
	SetUpStartingFruit()
	currentTimer.start(5.0)
	playerUI.SetUp()

func ResetValues():
	multiplierMax = multiplierLimits[selectedDifficulty]
	currentScore = 0
	mistakesCount = 0
	currentMultiplier = 1
	highestMultiplier = 1
	currentCombo = 0
	longestCombo = 0
	currentChordInSet = 0
	sortedFruits.clear()
	isPlaying = true
	isCheckingInput = false

func GetNodesRefs():
	playerUI = get_node("PlayerUI")
	CurrentFruitObject = get_node("CurrentFruit")
	currentTimer = get_node("Timer")

func SetUpStartingFruit():
	random.randomize()
	currentChordSet = random.randi() % allowedChordProgressionRange[selectedDifficulty]
	CurrentFruitObject.SetNewFruit(SelectNewFruitChord(2))

func CompareKeyToFruit(key):
	var currentFruit = get_node("CurrentFruit").currentFruit
	if(inputToFruitId[key] == currentFruit):
		SetUpCorrectFruit(currentFruit)
	else:
		SetUpIncorrectFruit()
	
	playerUI.UpdateText(str(currentMultiplier), "Multiplier")

func SetUpCorrectFruit(fruitId):
	currentScore += 100 * currentMultiplier
	
	IncreaseMultiplier()
	IncreaseCombo()
	
	playerUI.UpdateText(str(currentScore), "Score")
	sortedFruits.append(fruitId)
	emit_signal("PlaySFX", fruitId)
	var newFruitId = SelectNewFruitChord(fruitId)
	CurrentFruitObject.SetNewFruit(newFruitId)

func SetUpIncorrectFruit():
	currentMultiplier = 1
	mistakesCount += 1
	currentCombo = 0
	emit_signal("PlaySFX", 7)

func IncreaseMultiplier():
	if(currentMultiplier < multiplierMax):
		currentMultiplier += 1
		if(highestMultiplier < currentMultiplier):
			highestMultiplier = currentMultiplier

func IncreaseCombo():
	currentCombo += 1
	if(longestCombo < currentCombo):
		longestCombo = currentCombo

func SelectNewFruitChord(currentFruitId):
	var newFruitId
	
	# Select next chord to play in current chord progression set
	if(currentChordInSet < 3):
		SelectNewChordProgression()
		currentChordInSet = 0
		
	newFruitId = chordProgressions[currentChordSet][random.randi() % chordProgressions[currentChordSet].size()]
	currentChordInSet += 1
	
	# Reduce the chance of having the same fruits consecutively
	if(newFruitId == currentFruitId):
		for i in range(0, 2):
			newFruitId = chordProgressions[currentChordSet][random.randi() % chordProgressions[currentChordSet].size()]
			if(newFruitId != currentFruitId):
				break 
	return newFruitId 


func SelectNewChordProgression():
	if(selectedDifficulty != 0):
		for i in range(0, 3):
			var newChordSetId = random.randi() % allowedChordProgressionRange[selectedDifficulty]		
			if(newChordSetId != currentChordSet):
				currentChordSet = newChordSetId
				break
				
func _on_Timer_timeout():
	isPlaying = false
	
#	print("Main Game - _on_Timer_timeout()")
#	for i in range(0, sortedFruits.size()):
#		print("Sorted fruit {0}: {1}".format([i, idToName[sortedFruits[i]]]))
	
	emit_signal("TimeUp", currentScore, highestMultiplier, longestCombo, mistakesCount, sortedFruits, multiplierLimits[selectedDifficulty])
