extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().find_node("Player").hasABanana == true:
		$Banana.show()
	else:
		$Banana.hide()
	
	if get_parent().find_node("Player").canFixHole == true:
		$Dead.show()
	else:
		$Dead.hide()	
		
	$Money.text = str(Globals.Pognon)+ "$"
		
	pass
