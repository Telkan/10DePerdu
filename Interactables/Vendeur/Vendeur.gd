extends Area2D

var empty = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func take():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func showStuff():
	$Prompt.show()

func hideStuff():
	$Prompt.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
