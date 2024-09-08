extends Node2D

@export var bullet : CharacterBody2D
@export var speed : int
@export var radius : float

func _ready() -> void:
	var collision : CollisionShape2D = bullet.get_node("CollisionShape2D") as CollisionShape2D
	collision.position.y += radius

func _process(delta: float) -> void:
	bullet.velocity = Vector2(cos(bullet.rotation), sin(bullet.rotation)) * speed
	bullet.move_and_slide()
