extends Path2D

## Also need to connect Timer signal
@export var timer : Timer
@export var bullet_speed : float
## In seconds
@export var spawnrate : float

var scene_bullet : PackedScene = preload("res://Scene/Utilities/bullet_path_follow_2d.tscn")
var first_bullet : PathFollow2D

func _ready() -> void:
	timer.wait_time = spawnrate
	var bullet : PathFollow2D = scene_bullet.instantiate() as bullet_path_follow_2d
	bullet.speed = bullet_speed
	bullet.stop_spawn.connect(stop_timer)
	#bullet.stop_spawn.connect(stop_timer)
	add_child(bullet)
	first_bullet = bullet
	timer.start()

func _on_timer_timeout() -> void:
	var bullet : PathFollow2D = scene_bullet.instantiate() as bullet_path_follow_2d
	bullet.speed = bullet_speed
	#bullet.stop_spawn.connect(stop_timer)
	add_child(bullet)

func stop_timer() -> void:
	clean_up()

func clean_up() -> void:
	var main : Node2D = get_node("..")
	timer.queue_free()
	first_bullet.disconnect("stop_spawn", stop_timer)
	first_bullet.queue_free()
