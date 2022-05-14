extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$HoleCreator/Timer.wait_time = Globals.SpeedOfRocks
	Globals.nbOfHoles = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.nbOfHoles >= 5 and dead == false:
		$Level.queue_free()
		$PassengerList.queue_free()
		$HoleCreator.queue_free()
		$BananaTraps.queue_free()
		$DeadParticles.set_emitting(true)
		$MortBateau.play()
		
		$Vendeur.queue_free()
		dead = true
		
