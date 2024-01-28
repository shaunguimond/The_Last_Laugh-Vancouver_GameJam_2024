extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var DAMAGE = 30
@onready var anim = get_node("AnimatedSprite2D")
var aliveStatus = true

func _ready():
	anim.play("Idle")

func _physics_process(delta):
	#Gravity for Rat
	velocity.y += gravity * delta
	if chase == true:
		player = get_node("../mainHeroine")
		var  direction = (player.position - self.position).normalized()
		
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else: 
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if anim.animation != "Death":
			
			anim.play("Idle")
		velocity.x = 0
			
	
	move_and_slide()
 
func _on_player_detection_body_entered(body):
	if body.name == "mainHeroine":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "mainHeroine":
		chase = false


func _on_player_death_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "mainHeroine":
		Death()


func _on_player_collision_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "mainHeroine":
		if aliveStatus == true:
			#Game.playerHP -= DAMAGE
			Death()
	

func Death():
	Game.score += 5
	Util.saveGame()
	aliveStatus = false
	#Game.Gold += 1
	#Utils.saveGame()
	anim.play("Death")
	velocity.x = 0
	chase = false
	await anim.animation_finished
	self.queue_free()
	

#

#
#

#
#func _on_player_death_body_exited(body):
	#pass # Replace with function body.
