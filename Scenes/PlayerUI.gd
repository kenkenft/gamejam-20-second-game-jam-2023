extends Control

var scoreText 
var timerText
var multiplierText 


# Called when the node enters the scene tree for the first time.
func _ready():
	SetUp()

func SetUp():
	scoreText = get_node("Score")
	scoreText.text = "0"
	
	timerText = get_node("Timer")
	timerText.text = "Time Left: 20.0"
	
	multiplierText = get_node("Multiplier")
	multiplierText.text = "x1"
	

func UpdateText(var newText, var targetNode):
	match targetNode:
		"Score": scoreText.text = newText
		"Timer": timerText.text = newText
		"Multiplier": multiplierText.text = "x" + newText
