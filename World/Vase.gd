extends Node2D

const VaseEffect = preload ("res://Effects/VaseEffect.tscn")

func create_grass_effect():
	var vaseEffect = VaseEffect.instance()
	get_parent().add_child(vaseEffect)
	vaseEffect.global_position = global_position

func _on_HurtBox_area_entered(area):
	create_grass_effect()
	queue_free()
