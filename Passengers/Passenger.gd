extends Node2D

export var speed = 50

var path = []
var goal = Vector2()

export(NodePath) var NavPath
onready var Nav := get_node(NavPath)

# Called when the node enters the scene tree for the first time.
func _ready():
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
	if path.size() > 1:
		followPath(delta)
	
	
