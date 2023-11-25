extends Node2D

export var fruitSounds = [] #Index 0-6 are "Correct" fruit sounds, index 7 is "Incorrect" sound 

var acceptedInputActions = ["gameplay_sort_easy", "gameplay_sort_medium", "gameplay_sort_hard"] 
var multiplierLimits = [4, 8, 12]
var allowedFruits = [3, 5, 7]
var selectedDifficulty = 2
var inputToFruitId = {KEY_L: 0, KEY_S: 1, KEY_F: 2, KEY_D: 3, KEY_K: 4, KEY_SPACE: 5, KEY_J: 6 }
var CurrentFruitObject
var isPlaying = false
var isCheckingInput = false
var random = RandomNumberGenerator.new()
var audioStreamPlayer

var playerUI

var currentScore = 0
var currentMultiplier = 1
var multiplierMax


# Called when the node enters the scene tree for the first time.
func _ready():
	SetUp()

#ToDo Function that is called to set selectedDifficulty
#ToDo Increase score and multiplier on correct button input
#ToDo Reset multiplier on incorrect button input
#ToDo Generate next fruit (based on chord progression and available fruits) 

func _input(event):
	if (isPlaying && !isCheckingInput && event.is_action_pressed(acceptedInputActions[selectedDifficulty])):
		isCheckingInput = true
		CompareKeyToFruit(event.scancode)
		isCheckingInput = false

# ToDo: Set up game by difficulty
func SetUp():
	audioStreamPlayer = get_node("AudioStreamPlayer")
	playerUI = get_node("PlayerUI")
	multiplierMax = multiplierLimits[selectedDifficulty]
	currentScore = 0
	isPlaying = true
	isCheckingInput = false
	CurrentFruitObject = get_node("CurrentFruit")
	CurrentFruitObject.SetNewFruit(1)

func CompareKeyToFruit(key):
	#print(key)
	var currentFruit = get_node("CurrentFruit").currentFruit
	if(inputToFruitId[key] == currentFruit):
		SetUpCorrectFruit(currentFruit)
	else:
		SetUpInCorrectFruit()
	
	playerUI.UpdateText(str(currentMultiplier), "Multiplier")
	audioStreamPlayer.play()

func SetUpCorrectFruit(fruitID):
	currentScore += 100 * currentMultiplier
	
	if(currentMultiplier < multiplierMax):
		currentMultiplier += 1
	playerUI.UpdateText(str(currentScore), "Score")
	audioStreamPlayer.stream = fruitSounds[fruitID]
	CurrentFruitObject.SetNewFruit(random.randi_range(0,6))

func SetUpInCorrectFruit():
	currentMultiplier = 1
	audioStreamPlayer.stream = fruitSounds[7]
	#ToDo create yield/coroutine function that waits for 0.5 seconds
