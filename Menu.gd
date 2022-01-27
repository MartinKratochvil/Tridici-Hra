extends Node2D

func _ready():
	pass

func _on_ButtonPlay_pressed():
	get_tree().change_scene("res://Minigame"+str(Score.Scene+1)+".tscn")

func _on_ButtonClose_pressed():
	$Panel.visible = false

func _on_Button1_pressed():
	Score.Scene = 0
	LoadPanel()

func _on_Button2_pressed():
	Score.Scene = 1
	LoadPanel()

func _on_Button3_pressed():
	Score.Scene = 2
	LoadPanel()

func _on_ButtonEnd_pressed():
	get_tree().quit()
	
func LoadPanel():
	$Panel.visible = true
	$Panel/LabelHighScore.text = str(Score.BestScore[Score.Scene])
	if int(str(Score.BestScore[Score.Scene])) >= 1000:
		for i in 3: get_node("Panel/Star"+str(i+1)).set_texture(load("res://assets/Items/Star-yellow.png"))
	elif int(str(Score.BestScore[Score.Scene])) >= 500:
		for i in 2: get_node("Panel/Star"+str(i+1)).set_texture(load("res://assets/Items/Star-yellow.png"))
		$Panel/Star3.set_texture(load("res://assets/Items/Star-black.png"))
	elif int(str(Score.BestScore[Score.Scene])) >= 300:
		$Panel/Star1.set_texture(load("res://assets/Items/Star-yellow.png"))
		for i in 2: get_node("Panel/Star"+str(i+2)).set_texture(load("res://assets/Items/Star-black.png"))
	else: 
		for i in 3: get_node("Panel/Star"+str(i+1)).set_texture(load("res://assets/Items/Star-black.png"))
