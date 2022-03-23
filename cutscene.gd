extends Node2D

export var target_scene = "res://map4.tscn"

onready var animation = $AnimationPlayer
onready var animation2 = $AnimatedSprite

func _ready():
	animation.play("cutscene")
	animation2.play()


func _input(event):
	if Input.is_key_pressed(KEY_ENTER):
			next_level()


func next_level():
	var ERR = get_tree().change_scene(target_scene)
	if ERR != OK:
		print("error")
