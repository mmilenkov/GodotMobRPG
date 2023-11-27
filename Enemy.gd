extends Node2D

@onready var hpLabel = $HPLabel
@onready var animationPlayer = $AnimationPlayer

const battleUnits: BattleUnits = preload("res://battle_resources.tres")

signal died
signal endTurn

@export var hp: int = 25:
	get:
		return hp
	set(value):
		hp = value
		if hpLabel != null:
			hpLabel.text = str(hp) + "hp"

@export var damage: int = 4

func attack() -> void:
	await get_tree().create_timer(0.4).timeout
	animationPlayer.play("Attack")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		emit_signal("endTurn")

func take_damage(amount: int):
	self.hp -= amount
	if is_dead():
		emit_signal("died")
		queue_free()
	else:
		animationPlayer.play("Shake")

func deal_damage():
	battleUnits.Player.hp -= damage

func is_dead() -> bool:
	return hp <= 0

func _ready():
	battleUnits.Enemy = self

func _exit_tree():
	battleUnits.Enemy = null
