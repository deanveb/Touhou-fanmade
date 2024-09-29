extends Area2D

@export var resize_ammount : float
@export var duration : float
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	var tween : Tween = create_tween().parallel()
	tween.parallel().tween_property(collision_shape_2d, "scale:y", resize_ammount * 0.5, duration)
	tween.parallel().tween_property(collision_shape_2d, "position:y", resize_ammount * 0.5, duration)
