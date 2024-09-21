extends Path2D

## Also need to connect Timer signal
@export var timer : Timer

var scene_bullet : PackedScene = preload("res://Scene/Utilities/bullet_path_follow_2d.tscn")

func _on_timer_timeout() -> void:
	var bullet : PathFollow2D = scene_bullet.instantiate() as bullet_path_follow_2d
	bullet.speed = 0.01
	#bullet.stop_spawn.connect(stop_timer)
	add_child(bullet)

func stop_timer(area: Area2D) -> void:
	clean_up()
	print("hi")

func clean_up() -> void:
	var main : Node2D = get_node("..")
	main.get_node("StopTimer").queue_free()
	main.get_node("Timer").queue_free()
