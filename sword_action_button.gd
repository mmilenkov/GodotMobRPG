extends "res://ActionButton.gd"

const Slash = preload("res://slash.tscn")

func _on_pressed():
	var enemy = battleUnits.Enemy
	var playerStats = battleUnits.Player
	if enemy != null and playerStats != null:
		create_attack_effect(enemy.global_position)
		enemy.take_damage(4)
		playerStats.mp += 2
		playerStats.ap -= 1

func create_attack_effect(targetPos):
	var slash = Slash.instantiate()
	owner.add_child(slash)
	slash.global_position = targetPos
