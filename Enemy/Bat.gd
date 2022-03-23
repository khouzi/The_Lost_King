extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200


var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
onready var stats = $Stats
onready var sprite = $AnimatedSprite
const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
onready var hurtbox = $HurtBox
onready var softcollison = $SoftCollision
onready var playerdetectionzone = $PlayerDetectionZone

enum{
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		
			
		WANDER:
			pass
			
			
		CHASE:
			var player = playerdetectionzone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x > 0
	if softcollison.is_colliding():
		velocity += softcollison.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)



func seek_player():
	if playerdetectionzone.can_see_player():
		state = CHASE

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120
	hurtbox.create_hit_effect()

