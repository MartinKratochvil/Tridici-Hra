extends Node2D

var firsttime = true
var rng = RandomNumberGenerator.new()
var item = null
var next = ["", "", ""]
var time = 180
var ready = true

func _ready():
	for i in 3:
		rng.randomize()
		match rng.randi_range(1,5):
			1:
				next[i] = "Paper"
				get_node("Background/Conveyor/Item"+String(i)).set_texture(load("res://assets/Items/Paper.png"))
			2: 
				next[i] = "Plastic"
				get_node("Background/Conveyor/Item"+String(i)).set_texture(load("res://assets/Items/Plastic.png"))
			3: 
				next[i] = "Glass"
				get_node("Background/Conveyor/Item"+String(i)).set_texture(load("res://assets/Items/Glass.png"))
			4: 
				next[i] = "Organic"
				get_node("Background/Conveyor/Item"+String(i)).set_texture(load("res://assets/Items/Organic.png"))
			5: 
				next[i] = "E-waste"
				get_node("Background/Conveyor/Item"+String(i)).set_texture(load("res://assets/Items/E-waste.png"))

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
							Score.score += 100
						elif item != null:
							print("kokote");
							item = null
							Score.score -= 100;
					"Plastic":
						if item == "Plastic":
							print("Plastic")
							item = null
							Score.score += 100
						elif item != null:
							print("kokote");
							item = null
							Score.score -= 100
					"Glass":
						if item == "Glass":
							print("Glass")
							item = null
							Score.score += 100
						elif item != null:
							print("kokote");
							item = null
							Score.score -= 100
					"Organic":
						if item == "Organic":
							print("Organic")
							item = null
							Score.score += 100
						elif item != null:
							print("kokote");
							item = null
							Score.score -= 100
					"E-waste":
						if item == "E-waste":
							print("E-waste")
							item = null
							Score.score += 100
						elif item != null:
							print("kokote");
							item = null
							Score.score -= 100
					"Conveyor":
						print("Conveyor")
						if item == null && ready:
							ready = false
							item = next[0]
							$Background/Player/body/Sprite.set_texture(load("res://assets/Items/" + item +".png"))
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
								get_node("Background/Conveyor/Item"+String(i)).set_texture(load("res://assets/Items/" + next[i] +".png"))
							print(item)
							ready = true
				if item == null : $Background/Player/body/Sprite.set_texture(load("res://assets/Items/None.png"))
				if Score.score < 0: Score.score = 0
				print("score: ", Score.score)
			else:
				#print("lol")
				pass
			firsttime = false
		else:
			firsttime = true

func _on_Timer1_timeout():
	time -= 1
	print(time, "s left")
	if (time <= 0):
		$Background/Timer1.stop()
		get_tree().change_scene("res://Menu.tscn")
