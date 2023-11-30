extends Node2D

export var Baskets = []

#Indexes 2, 5 and 6 will always be shown
var HideWhichBaskets = [[false, false, true, false, false, true, true], 
						[false, false, true, true, true, true, true],
						[true, true, true, true, true, true, true]] 

func _on_MainGame_ShowCrateByDifficulty(difficulty):
	for i in range(0, Baskets.size()):
		get_node(Baskets[i]).set_visible(HideWhichBaskets[difficulty][i])


func _on_TitleMenu_UpdateBasketVisibility(difficulty):
	_on_MainGame_ShowCrateByDifficulty(difficulty)
