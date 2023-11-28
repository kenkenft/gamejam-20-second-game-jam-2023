extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Main/TitleMenu/AllButtons/Easy").connect("OnDifficultySelected", self, "SetUpGame")
	get_node("Main/TitleMenu/AllButtons/Medium").connect("OnDifficultySelected", self, "SetUpGame")
	get_node("Main/TitleMenu/AllButtons/Hard").connect("OnDifficultySelected", self, "SetUpGame")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func SetUpGame(difficulty):
	print("Difficulty selected!")
