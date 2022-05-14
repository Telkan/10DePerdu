extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var doorOutPath
onready var doorOut := get_node(doorOutPath)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Arrow.set_rotation((get_position().angle_to_point(doorOut.get_position())))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_Entered(body):
	$Arrow.show()
	print("enTheorie on est là cest cool")
	body.approachDoor(doorOut.get_position())
	pass # Replace with function body.


func _on_Player_Exited(body):
	$Arrow.hide()
	body.leaveDoor()
	pass # Replace with function body.
