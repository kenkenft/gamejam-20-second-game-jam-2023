extends Node2D

export var menus = [] # Assumes index positions: 0 - TitleScreen; 1 - MainGameArea; 2 - ResultScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	menus.append(get_node("Main/TitleMenu"))
	menus.append(get_node("Main/MainGameArea/MainGame"))
	menus.append(get_node("Main/ResultScreen"))
	
	get_node("Main/TitleMenu/AllButtons/Easy").connect("OnDifficultySelected", self, "SetUpGame")
	get_node("Main/TitleMenu/AllButtons/Medium").connect("OnDifficultySelected", self, "SetUpGame")
	get_node("Main/TitleMenu/AllButtons/Hard").connect("OnDifficultySelected", self, "SetUpGame")
	
	get_node("PlayerData").connect("ShowDifferentMenu", self, "ShowMenu")
	get_node("Main/ResultScreen").connect("ShowDifferentMenu", self, "ShowMenu")
	
	ShowMenu(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func ShowMenu(menuId):
	var detectedMenus = menus.size()
	if(menuId < detectedMenus):
		for i in range(0, detectedMenus):
			if(i != menuId):
				menus[i].visible = false
			else:
				menus[i].visible = true

func SetUpGame(difficulty):
	#print("Difficulty selected!")
	ShowMenu(1)
	menus[1].selectedDifficulty = difficulty
	menus[1].SetUp()
