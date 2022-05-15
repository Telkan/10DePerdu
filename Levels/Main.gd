extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$HoleCreator/Timer.wait_time = Globals.SpeedOfRocks
	Globals.nbOfHoles = 0
	Globals.currentTime = Globals.timeToNextScreen
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.currentTime <= 0:
		#Victoire lole
		pass
	
	
	if Globals.nbOfHoles >= 5 and dead == false:
		$Level.queue_free()
		$PassengerList.queue_free()
		$HoleCreator.queue_free()
		$BananaTraps.queue_free()
		$DeadParticles.set_emitting(true)
		$MortBateau.play()
		
		$Vendeur.queue_free()
		dead = true
		


func _on_Timer_timeout():
	Globals.currentTime-=1
	pass # Replace with function body.
