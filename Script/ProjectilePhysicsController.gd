extends Node2D

@export_category("Target")
## The actual bullet (with CharacterBody2D data type)
@export var bullet : CharacterBody2D
@export_category("types")
@export var wave : bool
@export var straight : bool
@export_category("Straight")
@export var speed : int
@export_category("Wave")
## The bullet's collision
@export var collision : CollisionShape2D
@export var height : int
@export var duration : float

func _ready() -> void:
	if wave:
		var tween : Tween = create_tween().set_loops()
		#Collision original rotation is right so its side is the y axis
		tween.tween_property(collision, "position", Vector2(0, height), duration)
		tween.tween_property(collision, "position", Vector2(0, -height), duration)

func _process(_delta: float) -> void:
	if straight:
		var directionx : float = cos(bullet.rotation)
		var directiony : float = sin(bullet.rotation)
		bullet.velocity = Vector2(directionx, directiony) * speed 
	bullet.move_and_slide()
