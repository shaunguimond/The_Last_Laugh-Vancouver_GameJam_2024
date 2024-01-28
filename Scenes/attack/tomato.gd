extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")
const tomatoPath = preload("res://Scenes/attack/tomato.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var initial_vertical_velocity = -100.0  # Adjust as needed
var initial_horiz_velocity = 100.0  # Adjust as needed
#velocity = Vector2.ZERO


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



#func _process(delta):
	#var mouse_position = get_global_mouse_position()
	#var direction = (mouse_position - global_position).normalized()
	##velocity = direction * SPEED
	#var vertical_velocity = initial_vertical_velocity * cos(min(90,direction.angle()))
	#velocity.y = vertical_velocity



func _physics_process(delta):
	if is_on_floor() or is_on_wall():
		anim.play("splat")
		await anim.animation_finished
		self.queue_free()
		
		#velocity.y += gravity * delta
	else:
		velocity.y += (gravity*0.75) * delta
		
		
		
	#position += transform.x * SPEED * delta
	# Handle jump.

	move_and_slide()

func _on_area_2d_body_entered(body):
	
	pass # Replace with function body.
