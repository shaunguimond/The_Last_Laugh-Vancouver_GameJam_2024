extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _active_pcam: PhantomCamera2D
@onready var anim = get_node("AnimationPlayer")
var animation_locked = false
var direction : Vector2 = Vector2.ZERO


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Normal jump from floor
			jump()
			
		
	if velocity.y > 0:
		anim.play("Fall")
		animation_locked = false	
		
	if Input.is_action_just_pressed("roll"):
		animation_locked = true
		velocity.x = direction.x * SPEED * 20
		#get_node("CollisionShape2D").set_scale(0.5)
		anim.play("Roll")
		await anim.animation_finished
		animation_locked  = false
		#get_node("CollisionShape2D").set_scale(1)
		
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	
	if direction.x != 0 && $AnimatedSprite2D.animation != "Fall":
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	if not animation_locked:
		if direction.x != 0:
			anim.play("Run")
		else:
			anim.play("Idle")

func update_facing_direction():
	if direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	elif direction.x < 0:
		get_node("AnimatedSprite2D").flip_h = true
		
func jump():
	velocity.y = JUMP_VELOCITY
	anim.play("Jump")
	animation_locked = true
		
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		#anim.play("Jump")
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("move_left", "move_right")
	## Flip sprite based on direction of movement.
	#if direction == -1: 
		#get_node("AnimatedSprite2D").flip_h = true
	#elif direction == 1:
		#get_node("AnimatedSprite2D").flip_h = false
		#
		#
	#
	#if direction:
		#velocity.x = direction * SPEED
		#if velocity.y == 0:
			#anim.play("Run")
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#if velocity.y == 0:
			#anim.play("Idle")
	#
	#if velocity.y > 0:
		#anim.play("Fall")
#
	#move_and_slide()
	#
#
