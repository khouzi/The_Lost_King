extends Node2D

const HitEffect = preload ("res://Effects/HitEffect.tscn")
var player = null
onready var spikeanimation = $AnimationPlayer



func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position



func _on_HurtBox_body_entered(body):
	create_hit_effect()


func _on_spikedetectionzone_body_entered(body):
	spikeanimation.play("spikeon")


func _on_spikedetectionzone_body_exited(body):
	pass
