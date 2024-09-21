class_name bullet_path_follow_2d
extends PathFollow2D

signal stop_spawn

## On the scale of 0-1
@export var speed : float

func _ready() -> void:
	var pattern : Path2D = get_node("..")

func _process(delta: float) -> void:
	var prev_progress : float = progress_ratio
	progress_ratio += speed
	if progress_ratio < prev_progress:
		stop_spawn.emit()
