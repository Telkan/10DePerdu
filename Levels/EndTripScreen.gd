extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$murderer.text = str(Globals.killedPeople)+ " people"
	$money.text = "$"+ str(Globals.Pognon)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	Globals.timeToNextScreen += 60
	Globals.SpeedOfRocks -= 10
	get_tree().change_scene("res://Levels/Main.tscn")
