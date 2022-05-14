extends Node2D

export var speed = 100

var path = []
var goal = Vector2()

var rng = RandomNumberGenerator.new()
onready var Nav = get_tree().get_nodes_in_group("Nav")[0]



var currentState = Globals.State.MOVING
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
		currentState = Globals.State.IDLING

func falling(delta):
	print("aaaaaaaa")
	print(get_position())
	if path.size() >= 1:
		followPath(3*delta)
	else:
		var DeadBodies = load("res://Interactables/DeadBody/DeadBody.tscn")
		var body = DeadBodies.instance()
		body.name = "Dead"
		body.set_position(get_position())
		get_parent().add_child(body)
		queue_free()

func idleState(delta):
	#Decide to move
	if rng.randf() >0.9:
		chooseRandomNextMove()
		currentState = Globals.State.MOVING
	#Small Idle Movement
	elif rng.randf() > 0.5:
		var currentPos = get_position()
		currentPos.x += rng.randi_range(-30,30)
		setGoal(currentPos)
		currentState = Globals.State.MOVING
	#Static for a while
	else:
		get_tree().create_timer(rng.randf_range(0,2)).connect("timeout", self, "stopWaiting")
		currentState = Globals.State.WAITING


func stopWaiting():
	currentState = Globals.State.IDLING
	
func fall(fallpath, posTrap):
	path = []
	var i = 0
	while(i< fallpath.get_point_count()):
		path.append(fallpath.get_point_position(i) + posTrap)
		i+=1
		
	currentState = Globals.State.FALLING
	pass
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentState != Globals.State.FALLING:
		if $Sprite.frame == 0:
			set_rotation(deg2rad(-15))
		else:
			set_rotation(deg2rad(15))
	if currentState == Globals.State.MOVING:
		movingState(delta)
	elif currentState == Globals.State.IDLING:
		idleState(delta)
	elif currentState == Globals.State.WAITING:
		pass
	elif currentState == Globals.State.FALLING:
		falling(delta)
		self.rotation += 5 * delta
		
	else:
		currentState = Globals.State.IDLING 
