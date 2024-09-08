extends Node2D

@export_category("nodes")
@export var bullet : CharacterBody2D
@export var animation : AnimationPlayer
@export_category("varibles")
@export var speed : int
@export var radius : float
@export var start_speed : int
@export var end_speed : int
@export var mid_speed : int

func _ready() -> void:
	if animation:
		animation.play("movement")

func _process(delta: float) -> void:
	bullet.velocity = Vector2(cos(bullet.rotation), sin(bullet.rotation)) * speed
	bullet.move_and_slide()
