extends Node2D

func _ready():
	pass

func _on_Level1_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Panel.visible = true
			#get_tree().change_scene("res://Minigame1.tscn")


func _on_ButtonPlay_pressed():
	OS.alert("idk")


func _on_ButtonClose_pressed():
	$Panel.visible = false


func _on_Level2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Panel.visible = true
			#get_tree().change_scene("res://Minigame1.tscn")


func _on_Level3_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Panel.visible = true
			#get_tree().change_scene("res://Minigame1.tscn")


func _on_Button1_pressed():
	$Panel.visible = true


func _on_Button2_pressed():
	$Panel.visible = true


func _on_Button3_pressed():
	$Panel.visible = true
