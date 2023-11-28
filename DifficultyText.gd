extends Control

signal OnDifficultyMouseEnter
signal OnDifficultyMouseExit
signal OnDifficultySelected

export(int) var difficulty # 0 - Easy; 1 - Medium; 2 - Hard
var expectedFruits = [3, 5, 7] # Easy - 3; Medium - 5; Hard - 7
var expectedMaxMultiplier = [4, 8, 12] # Easy - 4; Medium - 8; Hard - 12

var baseString = "";
var buttonLabels = ["Easy", "Medium", "Hard"]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("DifficultyText").text = buttonLabels[difficulty]


func _on_DifficultyText_mouse_entered():
	var helpText = "[center]{0} difficulty\nExpected number of fruits: {1}\nMaximum multiplier: {2}".format([buttonLabels[difficulty], expectedFruits[difficulty], expectedMaxMultiplier[difficulty]])
	emit_signal("OnDifficultyMouseEnter", helpText, false, difficulty)


func _on_DifficultyText_mouse_exited():
	emit_signal("OnDifficultyMouseExit", "", true, 2)


func _on_DifficultyText_pressed():
	emit_signal("OnDifficultySelected", difficulty)
