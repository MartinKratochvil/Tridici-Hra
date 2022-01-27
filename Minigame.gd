extends Node2D

var firsttime = true
var rng = RandomNumberGenerator.new()
var item = null
var next = [null, null, null]
var time = [20, 15, 10]
var score = 0
var ready = true

func _ready():
	$Background/LabelTime.text = str(time[Score.Scene])+"s"
	for i in 3:
		rng.randomize()
		match rng.randi_range(1,5):
			1:
				next[i] = "Paper"
				get_node("Background/Conveyor/Item"+str(i)).set_texture(load("res://assets/Items/Paper.png"))
			2: 
				next[i] = "Plastic"
				get_node("Background/Conveyor/Item"+str(i)).set_texture(load("res://assets/Items/Plastic.png"))
			3: 
				next[i] = "Glass"
				get_node("Background/Conveyor/Item"+str(i)).set_texture(load("res://assets/Items/Glass.png"))
			4: 
				next[i] = "Organic"
				get_node("Background/Conveyor/Item"+str(i)).set_texture(load("res://assets/Items/Organic.png"))
			5: 
				next[i] = "E-waste"
				get_node("Background/Conveyor/Item"+str(i)).set_texture(load("res://assets/Items/E-waste.png"))
		match next[0]:
			"Paper": $Background/Conveyor/Label.text = "Popsaný sešit"
			"Plastic": $Background/Conveyor/Label.text = "PET lahev"
			"Glass": $Background/Conveyor/Label.text = "Skleněná flaška"
			"Organic": $Background/Conveyor/Label.text = "Šlupka od banánu"
			"E-waste": $Background/Conveyor/Label.text = "Vybité baterky"

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_E and firsttime:
			var body = $Background/Player/body.get_overlapping_areas()
			if body.size() > 0:
				match body[0].name:
					"Paper":
						if item == "Paper":
							print("Paper")
							item = null
							score += 100
						elif item != null:
							print("kokote");
							item = null
							score -= 100;
					"Plastic":
						if item == "Plastic":
							print("Plastic")
							item = null
							score += 100
						elif item != null:
							print("kokote");
							item = null
							score -= 100
					"Glass":
						if item == "Glass":
							print("Glass")
							item = null
							score += 100
						elif item != null:
							print("kokote");
							item = null
							score -= 100
					"Organic":
						if item == "Organic":
							print("Organic")
							item = null
							score += 100
						elif item != null:
							print("kokote");
							item = null
							score -= 100
					"E-waste":
						if item == "E-waste":
							print("E-waste")
							item = null
							score += 100
						elif item != null:
							print("kokote");
							item = null
							score -= 100
					"Conveyor":
						print("Conveyor")
						if item == null && ready:
							ready = false
							item = next[0]
							$Background/Player/body/Sprite.set_texture(load("res://assets/Items/" + item +".png"))
							match next[1]:
								"Paper": $Background/Conveyor/Label.text = "Popsaný sešit"
								"Plastic": $Background/Conveyor/Label.text = "PET lahev"
								"Glass": $Background/Conveyor/Label.text = "Skleněná flaška"
								"Organic": $Background/Conveyor/Label.text = "Šlupka od banánu"
								"E-waste": $Background/Conveyor/Label.text = "Vybité baterky"
							$Background/Conveyor/Item0.set_texture(load("res://assets/Items/None.png"))
							for i in 2: next[i] = next[i + 1]
							$Background/Conveyor/AnimatedSprite.play("on")
							for i in 4:
								$Background/Conveyor/Item1.position.x += 7.5
								$Background/Conveyor/Item2.position.x += 7.5
								yield(get_tree().create_timer(0.25), "timeout")
							$Background/Conveyor/AnimatedSprite.play("off")
							while next[1] == next[2]:
								rng.randomize()
								match rng.randi_range(1,5):
									1: next[2] = "Paper"
									2: next[2] = "Plastic"
									3: next[2] = "Glass"
									4: next[2] = "Organic"
									5: next[2] = "E-waste"
							$Background/Conveyor/Item1.position.x -= 30
							$Background/Conveyor/Item2.position.x -= 30
							for i in 3: 
								get_node("Background/Conveyor/Item"+str(i)).set_texture(load("res://assets/Items/" + next[i] +".png"))
							print(item)
							ready = true
				if item == null : $Background/Player/body/Sprite.set_texture(load("res://assets/Items/None.png"))
				if score < 0: score = 0
				print("score: ", score)
				$Background/LabelScore.text = str(score)
			firsttime = false
		else:
			firsttime = true

func _on_Timer1_timeout():
	time[Score.Scene] -= 1
	print(time[Score.Scene], "s left")
	$Background/LabelTime.text = str(time[Score.Scene])+"s"
	if (time[Score.Scene] <= 0):
		$Background/Timer1.stop()
		$PanelBody/Panel.visible = true
		$Background/Player/CanMove.text = "0"
		$PanelBody/Panel/LabelScore.text = str(score)
		if score > int(str(Score.BestScore[Score.Scene])):
			Score.BestScore[Score.Scene] = str(score)
		$PanelBody/Panel/LabelHighScore.text = str(Score.BestScore[Score.Scene])
		if score >= 1000:
			for i in 3: get_node("PanelBody/Panel/Star"+str(i+1)).set_texture(load("res://assets/Items/Star-yellow.png"))
		elif score >= 500:
			for i in 2: get_node("PanelBody/Panel/Star"+str(i+1)).set_texture(load("res://assets/Items/Star-yellow.png"))
			$PanelBody/Panel/Star3.set_texture(load("res://assets/Items/Star-black.png"))
		elif score >= 300:
			$PanelBody/Panel/Star1.set_texture(load("res://assets/Items/Star-yellow.png"))
			for i in 2: get_node("PanelBody/Panel/Star"+str(i+2)).set_texture(load("res://assets/Items/Star-black.png"))
		else: 
			for i in 3: get_node("PanelBody/Panel/Star"+str(i+1)).set_texture(load("res://assets/Items/Star-black.png"))
		var file = File.new()
		file.open("Save.dat", File.WRITE)
		file.store_string(Marshalls.utf8_to_base64(str(Score.BestScore[0])+"$"+str(Score.BestScore[1])+"$"+str(Score.BestScore[2])))
		file.close()

func _on_Button_pressed():
	get_tree().change_scene("res://Menu.tscn")
