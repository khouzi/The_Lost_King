extends Node2D

var can_open = false
var can_open2 = false


onready var buttonanimation = $AnimationPlayer



func _on_Area2D_body_entered(body):
	if body.name == "Player" or "player2":
		can_open = true
		buttonanimation.play("buttonon")

func _on_Area2D_body_exited(body):
	if body.name == "Player" or "player2":
		can_open = false
		buttonanimation.play("buttom off")

func _on_Area2D2_body_entered(body):
	if body.name == "Player" or "player2":
		can_open2 = true
		buttonanimation.play("buttonon2")

func _on_Area2D2_body_exited(body):
	if body.name == "Player" or "player2":
		can_open2 = false
		buttonanimation.play("bottonoff2")

func _input(event):
	if can_open == true and can_open2 == true:
		$Label.visible = true
		if Input.is_key_pressed(KEY_E):
			print("hi")
			buttonanimation.play("door")
			$"StaticBody2D/bab".disabled = true
	else:
		$Label.visible = false
