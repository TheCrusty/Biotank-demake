# Virtual base class for all states.
class_name VictoryState
extends Node

@export var targetKillCount = 7
var currentKillCount = 0

func _ready():
	EventBus.enemy_death.connect(_enemy_death_handler)

func triggerVictory():
	await get_tree().create_timer(2).timeout
	$victorySound.play()
	await $victorySound.finished
	get_tree().change_scene_to_file("res://GUI/dna_screen.tscn")

func checkVictory():
	if currentKillCount >= targetKillCount:
		triggerVictory()

func _enemy_death_handler():
	currentKillCount += 1
	checkVictory()
