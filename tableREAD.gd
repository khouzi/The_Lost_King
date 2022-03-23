extends Area2D

var can_interact = false
var can_interact2 = false
const DIALOG = preload("res://tawladia.tscn")
const DIALOG2 = preload("res://tawladia2.tscn")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$Label.visible = true
		can_interact = true
	if body.name == "Player2":
		$Label.visible = true
		can_interact2 = true

func _on_Area2D_body_exited(body):
		$Label.visible = false
		can_interact = false
		can_interact2 = false

func _input(event):
	if Input.is_key_pressed(KEY_E) and can_interact == true:
		$Label.visible = false
		var dialog = DIALOG.instance()
		get_parent().add_child(dialog)
	if Input.is_key_pressed(KEY_E) and can_interact2 == true:
		$Label.visible = false
		var dialog = DIALOG2.instance()
		get_parent().add_child(dialog)
