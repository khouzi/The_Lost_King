extends Area2D


export var target_scene = "res://map2.tscn"
onready var player1 = $"/root/PlayerStats"
onready var player2 = $"/root/PlayerStats2"

func _ready():
	pass
	
func _input(event):
	if event.is_action_pressed("Enter"):
		if !target_scene:
			return
		if (get_overlapping_bodies().size()) > 0:
			player1.health = player1.max_health
			player2.health = player2.max_health
			next_level()


func next_level():
	var ERR = get_tree().change_scene(target_scene)

	if ERR != OK:
		print("error")
