extends Node2D

@export_category("nodes")
@export var bullet : CharacterBody2D
@export var animation : AnimationPlayer
@export var collision : CollisionShape2D
@export_category("varibles")
@export var speed : int
@export var wave_speed : int
@export var radius : float
@export_category("types")
@export var wave : bool

func _ready() -> void:
	if animation:
		animation.play("wave")

func _process(delta: float) -> void:
	var directionx : float = cos(bullet.rotation)
	var directiony : float = sin(bullet.rotation)
	bullet.velocity = Vector2(directionx, directiony) * speed
	
	if wave:
		collision.position.x += wave_speed
	
	bullet.move_and_slide()
