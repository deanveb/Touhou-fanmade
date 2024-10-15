extends Area2D

@export var ammount_per_split : int = 1
@export var generation_limit : int
@onready var delay: Timer = $Delay

const SPEARS = preload("res://Scene/Stages/Stage2/BulletPattern/spears.tscn")
var generation : int = 0
var spears_container : Array

func _on_delay_timeout() -> void:
	if generation > generation_limit:
		return
	for i in range(ammount_per_split):
		spears_container.append(SPEARS.instantiate() as Area2D)
		spears_container[i].rotation = deg_to_rad(180) # if generation == 0 else rotation + 90 
		spears_container[i].global_position = global_position
		spears_container[i].generation = generation + 1
	var gap : float = 180 / (ammount_per_split + 1)
	var temp : float = 0
	for spear : Area2D in spears_container:
		temp += gap
		spear.rotation -= deg_to_rad(temp)
		get_node("..").add_child(spear)
	queue_free()
