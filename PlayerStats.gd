extends Node

const battleUnits: BattleUnits = preload("res://battle_resources.tres")

var max_hp: int = 25
var hp: int  = max_hp:
	get:
		return hp
	set(value):
		hp = clamp(value, 0, max_hp)
		emit_signal("hp_changed", hp)

var max_ap: int = 3
var ap: int = max_ap:
	get:
		return ap
	set(value):
		ap = clamp(value, 0, max_ap)
		emit_signal("ap_changed", ap)
		if ap == 0:
			emit_signal("end_turn")

var max_mp: int = 10
var mp: int = max_mp:
	get:
		return mp
	set(value):
		mp = clamp(value, 0, max_mp)
		emit_signal("mp_changed", mp)

signal end_turn
signal hp_changed(value)
signal ap_changed(value)
signal mp_changed(value)

func _ready():
	battleUnits.Player = self

func _exit_tree():
	battleUnits.Player = null
