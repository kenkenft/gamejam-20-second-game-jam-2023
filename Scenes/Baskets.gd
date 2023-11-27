extends Node2D

export var Baskets = []

#Indexes 2, 5 and 6 will always be shown
var HideWhichBaskets = [[false, false, true, false, false, true, true], [false, false, true, true, true, true, true],[true, true, true, true, true, true, true]] 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MainGame_ShowCrateByDifficulty(difficulty):
	for i in range(0, Baskets.size()):
		get_node(Baskets[i]).set_visible(HideWhichBaskets[difficulty][i])
