extends CanvasLayer

onready var player1 = $"/root/PlayerStats"
onready var player2 = $"/root/PlayerStats2"
var current_level = "res://World.tscn"

func _ready():
		$TextureRect.visible = false
		$Quit.visible = false
		$Retry.visible = false
	
func _input(event):
	event = (self.player1.health <= 0) and (self.player2.health <= 0)
	if event:
		$TextureRect.visible = true
		$Quit.visible = true
		$Retry.visible = true


func _on_Button_pressed():
	get_tree().reload_current_scene()
	player1.health = player1.max_health
	player2.health = player2.max_health
	$TextureRect.visible = false
	$Quit.visible = false
	$Retry.visible = false


func _on_Button2_pressed():
	get_tree().quit()


