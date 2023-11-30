extends Node2D

signal PlaySFX
signal PlayBGM
signal PlayBGMTitle
signal UpdateHighScore
signal ShowDifferentMenu
signal WaitOver

export var DynamicText = []
export var BonusText = []
export var Buttons = []
export(NodePath) var GameManager

var fruits = []
var finalScore = 0
var difficulty
var idToName = {0: "Apple", 1: "Banana", 2: "Cherry", 3: "Durian", 4: "Egusi", 5: "Fig", 6: "Grapefruit"}
var WaitTimeLeft = 0
var isWaiting = false
var metronome

func _on_PlayerData_UpdateResultScreen(resultData, sortedFruits):
	SetUp()
	
	fruits.append_array(sortedFruits)	
	difficulty = resultData[4]
	finalScore = resultData[0]
	var finalScoreMessage = ""
	
	#emit_signal("PlayBGMTitle")
	PlaySong()
	
	get_node(DynamicText[0]).bbcode_text = "[b]{0} points[/b]".format([resultData[0]])	# Initial score
	SetBonusCombo(resultData[1])
	SetBonusMultiplier(resultData[2])
	SetBonusMistakes(resultData[3], resultData[5])
	get_node(DynamicText[4]).bbcode_text = "[b]{0}[/b] points".format([finalScore]) # Final score after bonuses/penalties
	emit_signal("UpdateHighScore", finalScore, difficulty)

func SetUp():
	fruits.clear()
	for i in range(BonusText.size()):
		get_node(BonusText[i]).visible = false
		
	metronome = get_node("Metronome")
	print(metronome.get_class())
	#metronome.connect("timeout", self, "DecrementWaitTimeLeft")
	#self.connect("WaitOver", self, "StopWaiting")


func PlaySong():
	for i in range(0,fruits.size()):
		if(i % 3 == 0):
			#PlayAfterFewSeconds(0.5, i)
			yield(get_tree().create_timer(0.5), "timeout")
		else:
			#PlayAfterFewSeconds(0.25, i)
			yield(get_tree().create_timer(0.25), "timeout")
		emit_signal("PlaySFX", fruits[i])
		

func PlayAfterFewSeconds(timeToWait, fruit):
	WaitTimeLeft = timeToWait
	isWaiting = false
	while(WaitTimeLeft > 0):
		print("WaitTimeLeft: {0}".format([WaitTimeLeft]))
		if(!isWaiting):
			#yield(WaitForFewSeconds(timeToWait), "waitOver")
			print("isWaiting: False")
			WaitForFewSeconds()
			print("Starting metronome")
			metronome.start(0.25)
			#yield(WaitForFewSeconds(), "WaitOver")
			#yield(metronome.start(0.25), "timeout")
			#isWaiting = true
		else:
			print("isWaiting: True")
	emit_signal("PlaySFX", fruits[fruit])

func WaitForFewSeconds():
	print("WaitForFewSeconds entered")
	isWaiting = true
	#yield(get_node("Metronome"), "timeout")
	print("WaitForFewSeconds yielded")
	#yield(get_tree().create_timer(0.25), "timeout")
	yield(get_node("Metronome"), "WaitOver")
	print("WaitForFewSeconds resumed")
	#isWaiting = false
	#WaitTimeLeft -= 0.25
	print("WaitForFewSeconds finished")
	#emit_signal("WaitOver")

func DecrementWaitTimeLeft():
	print("DecrementWaitTimeLeft() called")
	WaitTimeLeft -= 0.25

func StopWaiting():
	print("StopWaiting() called")
	isWaiting = false

# resultData = [currentScore, longestCombo, highestMultiplier, 
#				mistakesCount, selectedDifficulty, multiplierLimits]


func _on_Metronome_timeout():
	print("_on_Metronome_timeout() called")
	emit_signal("WaitOver")


func _on_PlaySong_pressed():
	PlaySong()

func _on_Replay_pressed():
	emit_signal("PlaySFX", 8)
	emit_signal("PlayBGM", difficulty)
	get_node(GameManager).SetUpGame(difficulty)

func _on_TitleScreen_pressed():
	emit_signal("PlaySFX", 8)
	emit_signal("ShowDifferentMenu", 0)

func SetBonusCombo(comboLength):
	var comboBonus = comboLength * 50
	finalScore += comboBonus
	get_node(DynamicText[1]).bbcode_text = "[b]{0}[/b]".format([comboLength])	# Longest combo
	get_node(BonusText[0]).visible = true
	if(comboLength >= 1):
		get_node(BonusText[0]).bbcode_text = "[b][color=#18EE00]+{0}[/color][/b] points!".format([comboBonus])
	else:
		get_node(BonusText[0]).bbcode_text = "[b][color=#EF0000]You did nothing![/color][/b]".format([comboBonus])
	get_node(DynamicText[4]).bbcode_text = "[b]{0}[/b]".format([finalScore]) # Final score after bonuses/penalties

func SetBonusMultiplier(maxMultiplierAchieved):
	var bonus = (maxMultiplierAchieved) * 100
	
	get_node(DynamicText[2]).bbcode_text = "[b]{0}[/b]".format([maxMultiplierAchieved])	# Highest multiplier
	get_node(BonusText[1]).visible = true
	if(maxMultiplierAchieved > 1):
		finalScore += bonus
		get_node(BonusText[1]).bbcode_text = "[b][color=#18EE00]+{0}[/color][/b] points!".format([bonus])
	else:
		get_node(BonusText[1]).bbcode_text = "[b][color=#EF0000]No bonus![/color][/b]".format([bonus])
	get_node(DynamicText[4]).bbcode_text = "[b]{0}[/b]".format([finalScore]) # Final score after bonuses/penalties

func SetBonusMistakes(mistakesMade, multiplierBonus):
	var modifier = 0
	var bonusText = ""
	if(mistakesMade == 0 && fruits.empty()):
		bonusText = "[b][color=#EF0000]Didn't even try![/color][/b]"
	elif(mistakesMade == 0):
		modifier = multiplierBonus * 100
		bonusText = "[b][color=#18EE00]+{0}[/color][/b] points!"
	else:
		modifier = mistakesMade * -100
		bonusText = "[b][color=#EF0000]{0}[/color][/b] points!"
		
	finalScore += modifier
	
	get_node(DynamicText[3]).bbcode_text = "[b]{0}[/b]".format([mistakesMade]) # Mistakes
	get_node(BonusText[2]).visible = true
	get_node(BonusText[2]).bbcode_text = bonusText.format([modifier])
	get_node(DynamicText[4]).bbcode_text = "[b]{0}[/b]".format([finalScore]) # Final score after bonuses/penalties

func _on_PlayerData_IndicateNewestHighScore():
	get_node(BonusText[3]).visible = true
	get_node(BonusText[3]).bbcode_text = "[b][color=#18EE00]New High Score![/color][/b]"



