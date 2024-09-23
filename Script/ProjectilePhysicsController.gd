extends Node2D

@export_category("Target")
## The actual bullet (with CharacterBody2D data type)
@export var bullet : CharacterBody2D
@export_category("Modes")
@export var wave : bool
@export var straight : bool
@export var rotating : bool
@export var step : bool
@export_category("Straight")
@export var speed : int
@export var radius : float
@export_category("Wave")
## The bullet's collision
@export var collision : CollisionShape2D
## In degree
@export var rotate_to : float
@export var duration : float
@export_category("Rotate")
## In degree
@export var rotate_speed : float
@export_category("Step")
@export var sprite : Sprite2D
@export var gap : int
@export var step_delay : int

func _ready() -> void:
	if wave:
		collision.position.x = radius
		var tween : Tween = create_tween().set_loops()
		#Collision original rotation is right so its side is the y axis
		tween.tween_property(bullet, "rotation_degrees", bullet.rotation + rotate_to, duration)
		tween.tween_property(bullet, "rotation_degrees", bullet.rotation - rotate_to, duration)
	if step:
		var timer : Timer = Timer.new()
		timer.autostart = true
		timer.wait_time = step_delay
		timer.timeout.connect(step_delay_timeout)
		bullet.add_child.call_deferred(timer)

func _process(_delta: float) -> void:
	var directionx : float = cos(bullet.rotation)
	var directiony : float = sin(bullet.rotation)
	if straight:
		bullet.velocity = Vector2(directionx, directiony) * speed 
	if rotating:
		bullet.rotation += deg_to_rad(rotate_speed)
	bullet.move_and_slide()

func step_delay_timeout() -> void:
	var directionx : float = cos(bullet.rotation)
	var directiony : float = sin(bullet.rotation)
	bullet.global_position += Vector2(directionx, directiony) * ((sprite.texture.get_height() * sprite.scale) / 2)
	print(sprite.texture.get_height())