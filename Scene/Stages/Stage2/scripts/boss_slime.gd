extends Area2D

const SLIME_BOMB = preload("res://Scene/Stages/Stage2/BulletPattern/slime_bomb.tscn")

@export var travel_time : float = 1
@export var slimeball_amount : int = 1

@onready var boss_sprite: Sprite2D = $BossSprite
@onready var boss_shadow: Sprite2D = $BossShadow
@onready var hitbox: CollisionPolygon2D = $Hitbox
@onready var attack_delay: Timer = $AttackDelay

func _on_attack_delay_timeout() -> void:
	if get_node_or_null("../Player"):
		var player : CharacterBody2D = get_node("../Player")
		switch_state()
		var tween : Tween = create_tween()
		tween.tween_property(self, "global_position", player.global_position, travel_time) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN)
		
		await tween.finished
		
		scatter_slimeball()
		switch_state()
		attack_delay.start()
		
func switch_state() -> void:
	if boss_shadow.visible:
		boss_shadow.hide()
		boss_sprite.show()
		hitbox.disabled = false
	else:
		boss_shadow.show()
		boss_sprite.hide()
		hitbox.disabled = true
		
func scatter_slimeball() -> void:
	for i in range(slimeball_amount):
		var slimeball : Area2D = SLIME_BOMB.instantiate()
		
		slimeball.rotation = randi() % 361
		slimeball.explode_delay = randf_range(0.2, 0.5)
		slimeball.global_position = self.global_position
		
		get_node("..").add_child(slimeball)
