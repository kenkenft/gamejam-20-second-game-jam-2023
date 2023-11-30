extends Control

var scoreText 
var timerText
var multiplierText 
var countdownText
var currentTimer

func SetUp():
	scoreText = get_node("Score")
	scoreText.bbcode_text = "Score: 0"
	
	timerText = get_node("Timer")
	timerText.bbcode_text = "Time Left: 20.0"
	
	multiplierText = get_node("Multiplier")
	multiplierText.bbcode_text = "[right]x1"
	
	countdownText = get_node("Countdown")
	countdownText.bbcode_text = "[center]3"
	
	currentTimer = get_node("../Timer")
	#print(currentTimer.get_time_left())

func _process(_delta):
#	while(!currentTimer.is_stopped()):
	if(currentTimer != null):
		if(!currentTimer.is_stopped()):
			UpdateText( str( stepify(currentTimer.get_time_left(), 0.1)), "Timer")
			#UpdateText("Timer", str(1.0))

func UpdateText(var newText, var targetNode):
	match targetNode:
		"Score": scoreText.bbcode_text = "Score: " + newText
		"Timer": timerText.bbcode_text = "Time Left: " + newText
		"Multiplier": multiplierText.bbcode_text = "[right]x" + newText
		"Countdown": countdownText.bbcode_text = "[center]" + newText
