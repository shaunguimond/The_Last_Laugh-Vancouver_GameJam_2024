extends CharacterBody2D

var health = 100
var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var DAMAGE = 30
@onready var anim = get_node("AnimatedSprite2D")
var aliveStatus = true

func _ready():
	anim.play("Idleover50")

func _physics_process(delta):
	#Gravity for Rat
	velocity.y += gravity * delta
	if chase == true:
		player = get_node("../../mainHeroine")
		var  direction = (player.position - self.position).normalized()
		
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else: 
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if anim.animation != "Death":
			
			anim.play("Idleover50")
		velocity.x = 0
		
	
	
	move_and_slide()
	
	if health > 50:
		anim.play("Idleover50")
	elif health > 0:
		anim.play("Idleunder50")
	else:
		Death()
 
func _on_player_detection_body_entered(body):
	if body.name == "mainHeroine":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "mainHeroine":
		chase = false

func _on_player_damage_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "Tomato":
		if aliveStatus == true:
			health -= 10



func _on_player_collision_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "mainHeroine":
		if aliveStatus == true:
			Game.playerHP -= DAMAGE
	


func Death():
	aliveStatus = false
	Game.score += 100
	#Game.Gold += 1
	#Utils.saveGame()
	#anim.play("Death")
	velocity.x = 0
	chase = false
	#await anim.animation_finished
	self.queue_free()
	get_tree().change_scene_to_file("res://Scenes/win.tscn")
	

		

