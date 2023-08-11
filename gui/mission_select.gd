extends Node2D

var first_mission = preload("res://levels/test_level.tscn").instantiate()
var second_mission = preload("res://levels/level2.tscn").instantiate()
var third_mission = preload("res://levels/level_3.tscn").instantiate()

func _on_mission_one_pressed():
	queue_free()
	get_tree().get_root().add_child(first_mission)
func _on_mission_two_pressed():
	queue_free()
	get_tree().get_root().add_child(second_mission)
func _on_mission_three_pressed():
	queue_free()
	get_tree().get_root().add_child(third_mission)
