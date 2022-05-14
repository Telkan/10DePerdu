extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()
var fixPercent
var accessible = false
func _ready():
	rng.randomize()
	var currentPosition = get_position()
	currentPosition.y += rng.randf_range(-10.0, 10.0)
	set_position(currentPosition)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func suicide():
	queue_free()

func _on_Area2D_area_entered(area):
	#TODO Shake caméra & all
	$Sprite.show()
	$SoundEffect.play()
	$Sprite/Splinters.set_emitting(true)
	accessible = true
	pass # Replace with function body.


func _on_PlayerDetect_area_entered(area):
	fixPercent = 0
	pass # Replace with function body.
