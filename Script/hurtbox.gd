extends Area2D

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.name == "Bullet":
		queue_free()
