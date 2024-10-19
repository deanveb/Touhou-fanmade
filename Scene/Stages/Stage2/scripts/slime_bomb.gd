extends Area2D

@export var explode_delay : float = 1

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var slime_splash: Sprite2D = $SlimeSplash
@onready var projectile_physics_controller: Node2D = $ProjectilePhysicsController
@onready var explode_time: Timer = $ExplodeTime
@onready var despawn: Timer = $Despawn

func  _ready() -> void:
	explode_time.wait_time = explode_delay
	explode_time.start()

func _on_explode_time_timeout() -> void:
	collision_shape_2d.queue_free()
	slime_splash.show()
	slime_splash.global_rotation_degrees = 0
	var hitbox : Area2D = slime_splash.get_node("Area2D")
	hitbox.monitorable = true
	hitbox.monitoring = true
	projectile_physics_controller.queue_free()
	despawn.start()

func _on_despawn_timeout() -> void:
	queue_free()
