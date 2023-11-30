extends Node2D

var currentFruit := 0 # 0-6. 0-Apple; 1-Banana; 2-Cherry; 3-Durian; 4-Egusi; 5-Fig; 6-Grapefruit 

# ToDo Update fruit sprite and currentFruitID
func SetNewFruit(fruitID):
	currentFruit = fruitID
	get_node("FruitSprite").frame = fruitID
