extends Node2D

signal UpdateBasketVisibility
signal GetHighScores

export var HighScores = []

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


func _on_TitleMenu_visibility_changed():
	if(self.visible):
		UpdateVariableText(defaultText, true, 2)
		emit_signal("GetHighScores")


func _on_PlayerData_ShowHighScores(currentHighScores):
	for i in range(0,currentHighScores.size()):
		get_node(HighScores[i]).bbcode_text = "[center][b]{0}[/b] points".format([currentHighScores[i]])
