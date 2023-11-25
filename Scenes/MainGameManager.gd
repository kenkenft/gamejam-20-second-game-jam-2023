extends Node2D

export var fruitSounds = [] #Index 0-6 are "Correct" fruit sounds, index 7 is "Incorrect" sound 

var acceptedInputActions = ["gameplay_sort_easy", "gameplay_sort_medium", "gameplay_sort_hard"] 
var selectedDifficulty = 2
var inputToFruitId = {KEY_L: 0, KEY_S: 1, KEY_F: 2, KEY_D: 3, KEY_K: 4, KEY_SPACE: 5, KEY_J: 6 }
var CurrentFruitObject
var isPlaying = false
var isCheckingInput = false
var random = RandomNumberGenerator.new()
var audioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	SetUp()

#ToDo Set up table/dictionary for fruit ids and keyboard inputs
#ToDo Check keyboard input against current fruit
	#ToDo Increase score and multiplier, and play corresponding fruit sound on correct button input
	#ToDo Reset multiplier and play incorrect tone on incorrect button input
#ToDo Generate next fruit (based on chord progression and available fruits) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
	#if(isPlaying && !isCheckingInput)

func _input(event):
	if (isPlaying && !isCheckingInput && event.is_action_pressed(acceptedInputActions[selectedDifficulty])):
		isCheckingInput = true
		
		print(event.as_text())
		if(inputToFruitId[event.scancode] == get_node("CurrentFruit").currentFruit):
			audioStreamPlayer.stream = fruitSounds[get_node("CurrentFruit").currentFruit]
			CurrentFruitObject.SetNewFruit(random.randi_range(0,6))
		else:
			audioStreamPlayer.stream = fruitSounds[7]
			
		audioStreamPlayer.play()
		isCheckingInput = false

# ToDo: Set up game by difficulty
func SetUp():
	audioStreamPlayer = get_node("AudioStreamPlayer")
	isPlaying = true
	isCheckingInput = false
	CurrentFruitObject = get_node("CurrentFruit")
	CurrentFruitObject.SetNewFruit(1)

func CheckInputCorrect(key):
	pass
