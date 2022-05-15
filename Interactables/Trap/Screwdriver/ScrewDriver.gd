extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var empty = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.canUnscrewBarrier:
		$Sprite.show()
		empty = false
	pass # Replace with function body.

func setup():
	$Sprite.show()
	empty = false
	
func take():
	empty = true
	$Sprite.hide()
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	empty = false
	$Sprite.show()
	pass # Replace with function body.
