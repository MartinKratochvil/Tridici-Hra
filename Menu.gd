extends Node2D

func _ready():
	pass

func _on_Level1_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_tree().change_scene("res://Minigame1.tscn")
