extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.hasABanana == true:
		$Banana.show()
	else:
		$Banana.hide()
	
	if Globals.canFixHole == true:
		$Dead.show()
	else:
		$Dead.hide()	
		
	if Globals.nbOfHoles == 4:
		$AlertHole.show()
	else:
		$AlertHole.hide()
		
	if Globals.hasScrewdriver == true:
		$HasScrew.show()
	else:
		$HasScrew.hide()
		
	$Money.text = "$"+ str(Globals.Pognon)
	$Time.text = str(Globals.currentTime)+ "M"	
	pass
