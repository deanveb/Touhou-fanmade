extends Area2D

@export var speed : int = 400

func _process(delta: float) -> void:
	position.y -= speed * delta
