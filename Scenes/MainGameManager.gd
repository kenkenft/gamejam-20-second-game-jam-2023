extends Node2D

export var fruitSounds = [] #Index 0-6 are fruit sounds, index 7 is "Incorrect" sound 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#ToDo Set up table/dictionary for fruit ids and keyboard inputs
#ToDo Check keyboard input against current fruit
	#ToDo Increase score and multiplier, and play corresponding fruit sound on correct button input
	#ToDo Reset multiplier and play incorrect tone on incorrect button input
#ToDo Generate next fruit (based on chord progression and available fruits) 

# ToDo: Set up game by difficulty
func _setUp():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
