extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var activated = false

export(NodePath) var fallingPathNode
onready var fallingPath = get_node(fallingPathNode) 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setTrap():
	activated = true
	$BananaSprite.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Banana_area_entered(area):
	var victim = area.get_parent()
	if victim.currentState != Globals.State.FALLING and activated == true:
		$SoundEffect.play()
		victim.fall(fallingPath.get_curve(), get_position())
		activated = false
		$BananaSprite.hide()
		fallingPath = get_node(fallingPathNode) 
	pass # Replace with function body.
