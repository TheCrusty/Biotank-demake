extends Node2D

var first_mission = preload("res://levels/test_level.tscn").instantiate()


func _on_mission_one_pressed():
	queue_free()
	get_tree().get_root().add_child(first_mission)
