extends KinematicBody2D



export var FRICTION = 500
export var ACCELERATION = 500
export var MAX_SPEEED = 80


var velocity = Vector2.ZERO 
onready var animationpalyer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback")
onready var swordhitbox = $Hitboxpivot/SwordHitbox
onready var hurtbox1 = $HurtBox
var stats = PlayerStats2
onready var blinkanimation = $Blinkanimationplayer


enum {
	MOVE,
	SHEILD,
	ATTACK,
	DEATH,
	SHIELD
}

var state = MOVE

func _ready():
	animationtree.active = true
	swordhitbox.knockback_vector = Vector2.LEFT

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		SHIELD:
			shield_state()
		ATTACK:
			attack_state()
		DEATH:
			death_state()

func move_state(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		swordhitbox.knockback_vector = input_vector
		animationtree.set("parameters/Idle/blend_position", input_vector)
		animationtree.set("parameters/Run/blend_position", input_vector)
		animationtree.set("parameters/Attack/blend_position", input_vector)
		animationtree.set("parameters/Death/blend_position", input_vector)
		animationtree.set("parameters/Shield/blend_position", input_vector)
		animationstate.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEEED, ACCELERATION * delta)
		
	else:
		animationstate.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	if Input.is_action_just_pressed("attack2"):
		state = ATTACK
	if Input.is_action_just_pressed("shield"):
		pass
func move():
	velocity = move_and_slide(velocity)
	
func attack_state():
	velocity = Vector2.ZERO
	animationstate.travel("Attack")
	
func attack_animation_finished():
	state = MOVE	
	
func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	hurtbox1.start_invincibility(0.6)
	hurtbox1.create_hit_effect()
	if stats.health == 0:
		state = DEATH

func death_state():
	animationstate.travel("Death")
	$HurtBox/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
	
	


func shield_state():
	animationstate.travel("Shield")
	
func shield_animation_finished():
	if Input.is_action_just_released("shield"):
		state = MOVE




func _on_HurtBox_invincibility_started():
	blinkanimation.play("start")


func _on_HurtBox_invincibility_ended():
	blinkanimation.play("stop")
