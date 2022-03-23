extends Node2D


export var target_scene = "res://map0.tscn"

func _ready():
	$AnimationPlayer.play("G")
	
func _input(event):
	if event.is_action_pressed("Enter"):
			next_level()


func next_level():
	var ERR = get_tree().change_scene(target_scene)

	if ERR != OK:
		print("error")
