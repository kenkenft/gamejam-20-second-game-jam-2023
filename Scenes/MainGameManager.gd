extends Node2D

signal PlaySFX
signal TimeUp
signal ShowCrateByDifficulty

var acceptedInputActions = ["gameplay_sort_easy_v3", "gameplay_sort_medium_v3", "gameplay_sort_hard_v3"] # WASD and IJKL scheme. 
var inputToFruitId = {KEY_L: 0, KEY_A: 1, KEY_D: 2, KEY_W: 3, KEY_I: 4, KEY_SPACE: 5, KEY_J: 6 }# WASD and IJKL scheme.


var multiplierLimits = [4, 8, 12]
var allowedFruits = [3, 5, 7]
var selectedDifficulty = 2

var CurrentFruitObject
var isPlaying = false
var isCheckingInput = false
var random = RandomNumberGenerator.new()

var idToName = {0: "Apple", 1: "Banana", 2: "Cherry", 3: "Durian", 4: "Egusi", 5: "Fig", 6: "Grapefruit"}

var playerUI

var currentScore = 0
var currentMultiplier = 1
var highestMultiplier = 1
var currentTimer
var mistakesCount = 0
var currentCombo = 0
var longestCombo = 0
var multiplierMax
var sortedFruits = []


# Called when the node enters the scene tree for the first time.
func _ready():
	SetUp()

#ToDo Function that is called to set selectedDifficulty
#ToDo Generate next fruit (based on chord progression and available fruits) 

func _input(event):
	if (isPlaying && !isCheckingInput && event.is_action_pressed(acceptedInputActions[selectedDifficulty])):
		isCheckingInput = true
		CompareKeyToFruit(event.scancode)
		#yield(get_tree().create_timer(0.10), "timeout")
		isCheckingInput = false

# ToDo: Set up game by difficulty
func SetUp():
	emit_signal("ShowCrateByDifficulty", selectedDifficulty)
	playerUI = get_node("PlayerUI")
	multiplierMax = multiplierLimits[selectedDifficulty]
	currentScore = 0
	mistakesCount = 0
	currentMultiplier = 1
	highestMultiplier = 1
	currentCombo = 0
	longestCombo = 0
	sortedFruits.clear()
	isPlaying = true
	isCheckingInput = false
	CurrentFruitObject = get_node("CurrentFruit")
	CurrentFruitObject.SetNewFruit(1)
	currentTimer = get_node("Timer")
	currentTimer.start(20.0)
	playerUI.SetUp()

func CompareKeyToFruit(key):
	#print(key)
	var currentFruit = get_node("CurrentFruit").currentFruit
	if(inputToFruitId[key] == currentFruit):
		SetUpCorrectFruit(currentFruit)
	else:
		SetUpIncorrectFruit()
	
	playerUI.UpdateText(str(currentMultiplier), "Multiplier")

func SetUpCorrectFruit(fruitID):
	currentScore += 100 * currentMultiplier
	
	if(currentMultiplier < multiplierMax):
		currentMultiplier += 1
		if(highestMultiplier < currentMultiplier):
			highestMultiplier = currentMultiplier
	currentCombo += 1
	if(longestCombo < currentCombo):
		longestCombo = currentCombo
	playerUI.UpdateText(str(currentScore), "Score")
	sortedFruits.append(fruitID)
	print("Item " + str(sortedFruits.size()) +idToName[fruitID])
	emit_signal("PlaySFX", fruitID)
	CurrentFruitObject.SetNewFruit(random.randi_range(0,6))

func SetUpIncorrectFruit():
	currentMultiplier = 1
	mistakesCount += 1
	emit_signal("PlaySFX", 7)


func _on_Timer_timeout():
	print("Time Up!")
	emit_signal("TimeUp", currentScore, highestMultiplier, longestCombo, mistakesCount, sortedFruits)
	#ToDo EndGame function
