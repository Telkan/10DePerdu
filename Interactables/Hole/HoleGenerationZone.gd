extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var sizeX = 200
export var sizeY = 100

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.


func spawnHole():
	var Holes = load("res://Interactables/Hole/Hole.tscn")
	var newHole = Holes.instance()

	var posX = rng.randi_range(-sizeX,sizeX)
	var posY = rng.randi_range(-sizeY,sizeY)
	newHole.set_position(Vector2(posX,posY))
	self.add_child(newHole)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():

	spawnHole()
	pass # Replace with function body.
