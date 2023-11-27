extends Node

@onready var buttonGrid = $UI/ButtonGridContainer
@onready var animationPlayer = $AnimationPlayer
@onready var forwardButton = $UI/CenterContainer/ForwardButton
@onready var enemyPos = $EnemyPos

const battleUnits: BattleUnits = preload("res://battle_resources.tres")

@export var enemies: Array[PackedScene] = []

signal enemyEndTurn

func _ready():
	start_player_turn()
	create_new_enemy()

func start_enemy_turn():
	buttonGrid.hide()
	var enemy = battleUnits.Enemy
	if enemy != null and not enemy.is_queued_for_deletion():
		enemy.attack()

func start_player_turn():
	buttonGrid.show()
	var player = battleUnits.Player
	if player != null:
		player.ap = player.max_ap

func connect_enemy_signal():
	var enemy = battleUnits.Enemy
	if enemy != null:
		var enemyDiedCallable = Callable(self, "_on_Enemy_died")
		enemy.died.connect(enemyDiedCallable)
		var endTurnCallable = Callable(self, "start_player_turn")
		enemy.endTurn.connect(endTurnCallable)

func _on_player_stats_end_turn():
	start_enemy_turn()

func create_new_enemy():
	randomize() #Randomise order of enemies
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instantiate()
	enemyPos.add_child(enemy)
	battleUnits.Enemy = enemy
	connect_enemy_signal()

func _on_Enemy_died():
	forwardButton.show()
	buttonGrid.hide()

func _on_forward_button_pressed():
	forwardButton.hide()
	var playerStats = battleUnits.Player
	playerStats.ap = playerStats.max_ap
	animationPlayer.play("RoomFade")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "RoomFade":
		buttonGrid.show()
		create_new_enemy()
