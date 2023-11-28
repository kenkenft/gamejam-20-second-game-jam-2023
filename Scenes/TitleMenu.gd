extends Node2D

signal UpdateBasketVisibility

var variableText
var basketsCanvas
var basketsDefaultPos
var basketsNewPos
var defaultText


# Called when the node enters the scene tree for the first time.
func _ready():
	variableText = get_node("VariableText")
	defaultText = variableText.text
	basketsCanvas = get_node("Baskets/CanvasLayer")
	basketsDefaultPos = basketsCanvas.get_position()
	basketsNewPos = Vector2(512, basketsDefaultPos[1])
	get_node("AllButtons/Easy").connect("OnDifficultyMouseEnter", self, "UpdateVariableText")
	get_node("AllButtons/Medium").connect("OnDifficultyMouseEnter", self, "UpdateVariableText")
	get_node("AllButtons/Hard").connect("OnDifficultyMouseEnter", self, "UpdateVariableText")
	
	get_node("AllButtons/Easy").connect("OnDifficultyMouseExit", self, "UpdateVariableText")
	get_node("AllButtons/Medium").connect("OnDifficultyMouseExit", self, "UpdateVariableText")
	get_node("AllButtons/Hard").connect("OnDifficultyMouseExit", self, "UpdateVariableText")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func UpdateVariableText(newText, showDefault, difficulty):
	if(!showDefault):
		variableText.bbcode_text = newText
		basketsCanvas.set_position(basketsNewPos)
	else:
		variableText.text = defaultText
		basketsCanvas.set_position(basketsDefaultPos)
	
	emit_signal("UpdateBasketVisibility", difficulty)
