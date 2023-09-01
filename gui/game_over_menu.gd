extends Node2D


func _on_mission_select_button_pressed():
	get_tree().change_scene_to_file("res://GUI/mission_select.tscn")
