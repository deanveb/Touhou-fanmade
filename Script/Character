extends CharacterBody2D 

var speed : int = 400
var slow : int = 200
var bulletOffset : Vector2 = Vector2(-30,200)
@onready var shift_fx:CPUParticles2D = $CPUParticles2D
@onready var bulletScene : PackedScene = preload("res://Aim.tscn")

func _ready() -> void:
	shift_fx.emitting = false
func get_input() -> void:
	var inp_direction : Vector2 = Input.get_vector("left","right","up","down")
	if Input.is_action_pressed("shift"):
		velocity = inp_direction * slow
		shift_fx.emitting = true
	else:
		velocity = inp_direction * speed
		shift_fx.emitting = false

func shoot() -> void:
	var bullet : Area2D = bulletScene.instantiate()
	bullet.position = position + bulletOffset
	get_parent().add_child(bullet)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()
	get_input()
	move_and_slide()
