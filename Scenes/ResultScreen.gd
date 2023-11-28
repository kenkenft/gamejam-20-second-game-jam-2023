extends Node2D

signal PlaySFX
signal UpdateHighScore
signal ShowDifferentMenu

export var DynamicText = []
export var BonusText = []
export var Buttons = []
export(NodePath) var GameManager

var fruits = []
var finalScore = 0
var difficulty
var idToName = {0: "Apple", 1: "Banana", 2: "Cherry", 3: "Durian", 4: "Egusi", 5: "Fig", 6: "Grapefruit"}
#func _ready():
	#get_node(Buttons[0]).connect("")
#	# Set up node button references
	# emit_signal("ShowDifferentMenu", 2)

func SetUp():
	fruits.clear()


func PlaySong():
	for i in range(0,fruits.size()):
		if(i % 3 == 0):
			yield(get_tree().create_timer(0.5), "timeout")
		else:
			yield(get_tree().create_timer(0.2), "timeout")
		emit_signal("PlaySFX", fruits[i])

# resultData = [currentScore, longestCombo, highestMultiplier, 
#				mistakesCount, selectedDifficulty, multiplierLimits]
func _on_PlayerData_UpdateResultScreen(resultData, sortedFruits):
	SetUp()
	
	fruits.append_array(sortedFruits)	
	difficulty = resultData[4]
	finalScore = resultData[0]
	
	PlaySong()
	get_node(DynamicText[0]).bbcode_text = "[b]{0} points[/b]".format([resultData[0]])	# Initial score
	SetBonusCombo(resultData[1])
	SetBonusMultiplier(resultData[2])
	SetBonusMistakes(resultData[3], resultData[5])
	get_node(DynamicText[4]).bbcode_text = "[b]{0}[/b] points".format([finalScore]) # Final score after bonuses/penalties
	emit_signal("UpdateHighScore", finalScore, difficulty)


func _on_PlaySong_pressed():
	PlaySong()


func _on_Replay_pressed():
	get_node(GameManager).SetUpGame(difficulty)


func _on_TitleScreen_pressed():
	emit_signal("ShowDifferentMenu", 0)

func SetBonusCombo(comboLength):
	var comboBonus = comboLength * 50
	finalScore += comboBonus
	get_node(DynamicText[1]).bbcode_text = "[b]{0}[/b]".format([comboLength])	# Longest combo
	if(comboLength > 1):
		get_node(BonusText[0]).bbcode_text = "[b][color=#18EE00]{0}[/color][/b] points!".format([comboBonus])
	get_node(DynamicText[4]).bbcode_text = "[b]{0}[/b]".format([finalScore]) # Final score after bonuses/penalties

func SetBonusMultiplier(maxMultiplierAchieved):
	var bonus = (maxMultiplierAchieved) * 100
	finalScore += bonus
	
	get_node(DynamicText[2]).bbcode_text = "[b]{0}[/b]".format([maxMultiplierAchieved])	# Highest multiplier
	if(maxMultiplierAchieved > 1):
		get_node(BonusText[1]).bbcode_text = "[b][color=#18EE00]{0}[/color][/b] points!".format([bonus])
	get_node(DynamicText[4]).bbcode_text = "[b]{0}[/b]".format([finalScore]) # Final score after bonuses/penalties

func SetBonusMistakes(mistakesMade, multiplierBonus):
	var modifier = 0
	var bonusText = ""
	if(mistakesMade == 0):
		modifier = multiplierBonus * 100
		bonusText = "[b][color=#18EE00]{0}[/color][/b] points!"
	else:
		modifier = mistakesMade * -100
		bonusText = "[b][color=#EF0000]{0}[/color][/b] points!"
		
	finalScore += modifier
	get_node(DynamicText[3]).bbcode_text = "[b]{0}[/b]".format([mistakesMade]) # Mistakes
	get_node(BonusText[2]).bbcode_text = bonusText.format([modifier])
	get_node(DynamicText[4]).bbcode_text = "[b]{0}[/b]".format([finalScore]) # Final score after bonuses/penalties
