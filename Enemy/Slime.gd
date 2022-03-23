extends KinematicBody2D


export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var animationtree = $AnimationTree
onready var hurtbox = $HurtBox
onready var playerdetectionzone = $PlayerDetectionZone
onready var stats = $Stats
onready var animationstate = animationtree.get("parameters/playback")

enum{
	IDLE,
	CHASE,
	WANDER
}
var state = IDLE

func _ready():
	animationtree.active = true

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			animationstate.travel("Wander")
			seek_player()
		CHASE:
			animationstate.travel("Chase")
			var player = playerdetectionzone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
	velocity = move_and_slide(velocity)
				
				
				
func seek_player():
	if playerdetectionzone.can_see_player():
		state = CHASE
			
			


func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120
	hurtbox.create_hit_effect()

func _on_Stats_no_health():
	queue_free()
