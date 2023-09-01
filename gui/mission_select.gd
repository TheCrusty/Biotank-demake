extends Node2D

func _on_mission_one_pressed():
	get_tree().change_scene_to_file("res://levels/test_level.tscn")
func _on_mission_two_pressed():
	get_tree().change_scene_to_file("res://levels/level2.tscn")
func _on_mission_three_pressed():
	get_tree().change_scene_to_file("res://levels/level_3.tscn")
