extends AudioStreamPlayer

export var fruitSounds = [] #Index 0-6 are "Correct" fruit sounds, index 7 is "Incorrect" sound 

#ar audioStreamPlayer 

#func _ready():
	#audioStreamPlayer = get_node("AudioStreamPlayer")

func PlayFruitSFX(fruitId):
	#audioStreamPlayer.stream = fruitSounds[fruitId]
	#audioStreamPlayer.play()
	stream = fruitSounds[fruitId]
	play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MainGame_PlaySFX(fruitId):
	PlayFruitSFX(fruitId)
