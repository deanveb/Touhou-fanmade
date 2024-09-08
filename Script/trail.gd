extends Line2D

@export var parent : CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = Vector2(0, 0)
	add_point(parent.global_position)
