extends Node2D

export var speed = 100

var path = []
var goal = Vector2()

var rng = RandomNumberGenerator.new()
onready var Nav = get_tree().get_nodes_in_group("Nav")[0]

export(Array,NodePath) var ListOfRooms

enum State {MOVING, IDLING, WAITING}
var currentState = State.MOVING
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	chooseRandomNextMove()
	
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
	
func chooseRandomNextMove():
	var listOfRooms = get_tree().get_nodes_in_group("Rooms")
	var chosenRoom = rng.randi_range(0,listOfRooms.size()-1)
	setGoal(listOfRooms[chosenRoom].get_position())

func movingState(delta):
	if path.size() >= 1:
		followPath(delta)
	else:
		currentState = State.IDLING

func idleState(delta):
	#Decide to move
	if rng.randf() >0.9:
		chooseRandomNextMove()
		currentState = State.MOVING
	#Small Idle Movement
	elif rng.randf() > 0.5:
		var currentPos = get_position()
		currentPos.x += rng.randi_range(-30,30)
		setGoal(currentPos)
		currentState = State.MOVING
	#Static for a while
	else:
		get_tree().create_timer(rng.randf_range(0,2)).connect("timeout", self, "stopWaiting")
		currentState = State.WAITING


func stopWaiting():
	currentState = State.IDLING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentState == State.MOVING:
		movingState(delta)
	elif currentState == State.IDLING:
		idleState(delta)
	elif currentState == State.WAITING:
		pass
	else:
		currentState = State.IDLING 
