extends KinematicBody2D

var scene
func _ready():
	scene = String(get_tree().get_current_scene().get_name())

export (int) var speed = 200

var velocity = Vector2()
var texture = load("res://assets/StickmanU.png")
var dir = "down"
var moving = false
#$Sprite.set_texture(load("res://assets/StickmanR.png"))

func get_input():
	velocity = Vector2()
	if($CanMove.text == "0"):
		return
	if Input.is_action_pressed("ui_right"):
		dir = "right"
		moving = true
		velocity.x += 1
		$body/Sprite.position.x = 12
		$body/Sprite.show()
	if Input.is_action_pressed("ui_left"):
		dir = "left"
		moving = true
		velocity.x -= 1
		$body/Sprite.position.x = -12
		$body/Sprite.show()
	if Input.is_action_pressed("ui_down"):
		dir = "down"
		moving = true
		velocity.y += 1
		$body/Sprite.position.x = 0
		$body/Sprite.show()
	if Input.is_action_pressed("ui_up"):
		dir = "up"
		moving = true
		velocity.y -= 1
		$body/Sprite.hide()
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	if moving:
		$AnimatedSprite.play(dir)
		moving = false
	else:
		$AnimatedSprite.play("s_" + dir)
	velocity = move_and_slide(velocity)	
