extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var empty = false

func take():
	empty = true
	$Pickup.hide()
	$Timer.start()

	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	empty = false
	$Pickup.show()
	pass # Replace with function body.
