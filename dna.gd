extends Node2D

var value = 10

func pickup():
	$PickupSound.play()
	await $PickupSound.finished
	queue_free()
