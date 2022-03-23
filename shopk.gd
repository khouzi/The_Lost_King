extends Area2D

var can_interact = false
const DIALOG = preload("res://shopkd.tscn")

func _physics_process(delta):
	$AnimatedSprite.play()


func _on_Node2D_body_entered(body):
	if body.name == "Player":
		$Label.visible = true
		can_interact = true
	


func _on_Node2D_body_exited(body):
	if body.name == "Player":
		$Label.visible = false
		can_interact = false
	

func _input(event):
	if Input.is_key_pressed(KEY_E) and can_interact == true:
		$Label.visible = false
		var dialog = DIALOG.instance()
		get_parent().add_child(dialog)






