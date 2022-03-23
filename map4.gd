extends Node2D


onready var player1 = $"/root/PlayerStats"
onready var player2 = $"/root/PlayerStats2"

func _ready():
	player1.health = player1.max_health
	player2.health = player2.max_health
