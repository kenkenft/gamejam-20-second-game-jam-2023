extends AudioStreamPlayer

export var fruitSounds = [] #Index 0-6 are "Correct" fruit sounds, index 7 is "Incorrect" sound 

func PlayFruitSFX(fruitId):
	stream = fruitSounds[fruitId]
	play()
	
func _on_MainGame_PlaySFX(fruitId):
	PlayFruitSFX(fruitId)

func _on_ResultScreen_PlaySFX(fruitId):
	PlayFruitSFX(fruitId)


func _on_Easy_PlaySFX(fruitId):
	PlayFruitSFX(fruitId)


func _on_Medium_PlaySFX(fruitId):
	PlayFruitSFX(fruitId)


func _on_Hard_PlaySFX(fruitId):
	PlayFruitSFX(fruitId)
