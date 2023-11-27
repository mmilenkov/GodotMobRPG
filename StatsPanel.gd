extends Panel

@onready var hpLabel: Label = $StatsContainer/HPLabel
@onready var apLabel: Label = $StatsContainer/APLabel
@onready var mpLabel: Label = $StatsContainer/MPLabel

func _on_player_stats_ap_changed(value):
	apLabel.text = "AP\n" + str(value)


func _on_player_stats_hp_changed(value):
	hpLabel.text = "HP\n" + str(value)


func _on_player_stats_mp_changed(value):
	mpLabel.text = "MP\n" + str(value)


func _on_hp_label_mouse_entered():
	set_text("Your remaining health.")


func _on_hp_label_mouse_exited():
	clear_text_box()


func _on_ap_label_mouse_entered():
	set_text("Your remaining action points.")


func _on_ap_label_mouse_exited():
	clear_text_box()


func _on_mp_label_mouse_entered():
	set_text("Your remaining mana.")


func _on_mp_label_mouse_exited():
	clear_text_box()

func clear_text_box():
	set_text("")

func set_text(text: String):
	var textBox = owner.find_child("TextBox")
	if textBox != null:
		textBox.text = text
