extends Node

var Tomato = preload("res://Collectable/tomato_collectible.tscn")

func _on_timer_timeout():
	var tomatoTemp = Tomato.instantiate()
	var rng = RandomNumberGenerator.new()
	var ranint = rng.randi_range(4600, 6500)
	tomatoTemp.position = Vector2(ranint, 650)
	add_child(tomatoTemp)



