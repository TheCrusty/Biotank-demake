extends Control


func _ready():
	$DNABar/DNAMeter.set_value(PlayerVariables.dnaCount)
