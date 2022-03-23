extends KinematicBody2D


export var FRICTION = 200
export var ACCELERATION = 300
export var MAX_SPEED = 50

var knockback = Vector2.ZERO


var velocity = Vector2.ZERO 
onready var animationplayer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback")
onready var playerdetectionzone = $PlayerDetectionZone
onready var stats = $Stats
onready var hurtbox = $HurtBox
onready var sprite = $Sprite
onready var timer = $Timer
onready var attack_zone = $AttackZone
const SkeletonDeathEffect = preload("res://Effects/SkeletonDeathEffect.tscn")

enum{
	IDLE,
	CHASE,
	WANDER,
	ATTACK,
	DEATH
}


var state = IDLE


func _ready():
	animationtree.active = true

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	if attack_zone.can_see_player():
		state = ATTACK
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			animationstate.travel("Idle")
			seek_player()
		CHASE:
			animationstate.travel("Run")
			var player = playerdetectionzone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x > 0
		ATTACK:
			attack_state()
			
			
			
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
	var skeletondeatheffect = SkeletonDeathEffect.instance()
	get_parent().add_child(skeletondeatheffect)
	skeletondeatheffect.global_position = global_position
		
	
func _on_Timer_timeout():
	queue_free()

func attack_state():
	animationstate.travel("Attack")
	velocity = Vector2.ZERO
	
func attack_animation_finiished():
	state = CHASE
	
