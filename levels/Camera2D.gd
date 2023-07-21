extends Camera2D

var isReady = false
# Called when the node enters the scene tree for the first time.
func _ready():
	isReady = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if isReady:
		global_position = get_parent().find_child("Player").global_position
