extends Node2D

var simultaneous_scene = preload("res://levels/test_level.tscn").instantiate()

func _on_play_button_pressed():
	queue_free()
	get_tree().get_root().add_child(simultaneous_scene)
