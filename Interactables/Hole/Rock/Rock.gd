extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 100
export var ondulation = 5
onready var posY = get_position().y 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var currentPos = get_position()
	currentPos.x += speed*delta
	currentPos.y = posY + ondulation * cos((currentPos.x * 0.05))
	set_position(currentPos)
	pass


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
	pass # Replace with function body.
