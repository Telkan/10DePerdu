extends Node2D

export var speed = 100

var path = []
var goal = Vector2()

var rng = RandomNumberGenerator.new()
onready var Nav = get_tree().get_nodes_in_group("Nav")

export(Array,NodePath) var ListOfRooms

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	Nav = Nav[0]
	pass # Replace with function body.


func setGoal(targetPosition):
	goal = targetPosition
	path = Nav.get_simple_path(get_position(),goal,false)

func followPath(delta):
	var d = get_position().distance_to(path[0])
	
	if d > 2:
		set_position(get_position().linear_interpolate(path[0], (speed * delta)/d ))
	else:
		path.remove(0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if path.size() >= 1:
		print("on est là?")
		followPath(delta)
	else:
		var listOfRooms = get_tree().get_nodes_in_group("Rooms")
		var chosenRoom = rng.randi_range(0,listOfRooms.size()-1)
		setGoal(listOfRooms[chosenRoom].get_position())
		print("on est là?")
