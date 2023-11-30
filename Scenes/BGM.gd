extends AudioStreamPlayer

export var BackgroundTrackDifficulty = []
export var BackgroundTrackTitle = []

var pointer = 0
var selectedDifficulty = 0
var random = RandomNumberGenerator.new()

func PlayBGMLevel(difficulty):
	stream = BackgroundTrackDifficulty[difficulty]
	play()
	
func PlayBGMTitle():
	stream = BackgroundTrackTitle[pointer]
	play()

func _on_Easy_PlayBGM(difficulty):
	selectedDifficulty = difficulty
	PlayBGMLevel(selectedDifficulty)


func _on_Medium_PlayBGM(difficulty):
	selectedDifficulty = difficulty
	PlayBGMLevel(selectedDifficulty)


func _on_Hard_PlayBGM(difficulty):
	selectedDifficulty = difficulty
	PlayBGMLevel(selectedDifficulty)


func _on_BGM_finished():
	random.randomize()
	pointer = random.randi() % BackgroundTrackTitle.size()
	PlayBGMTitle()


func _on_ResultScreen_PlayBGM(difficulty):
	selectedDifficulty = difficulty
	PlayBGMLevel(selectedDifficulty)
