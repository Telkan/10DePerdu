extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var empty = false

func take():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite/Money.set_emitting(true)
	$Sprite/Blood.set_emitting(true)

