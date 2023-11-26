extends Control

var scoreText 
var timerText
var multiplierText 
var currentTimer

func SetUp():
	scoreText = get_node("Score")
	scoreText.text = "Score: 0"
	
	timerText = get_node("Timer")
	timerText.text = "Time Left: 20.0"
	
	multiplierText = get_node("Multiplier")
	multiplierText.text = "x1"
	
	currentTimer = get_node("../Timer")
	#print(currentTimer.get_time_left())

func _process(delta):
#	while(!currentTimer.is_stopped()):
		UpdateText( str( stepify(currentTimer.get_time_left(), 0.1)), "Timer")
		#UpdateText("Timer", str(1.0))

func UpdateText(var newText, var targetNode):
	match targetNode:
		"Score": scoreText.text = "Score: " + newText
		"Timer": timerText.text = "Time Left: " + newText
		"Multiplier": multiplierText.text = "x" + newText
