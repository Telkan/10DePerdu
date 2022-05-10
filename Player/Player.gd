extends KinematicBody2D

export var GRAVITY = 200.0
export var WALK_SPEED = 250



var velocity = Vector2()

#---------<    TRAVERSE DOOR    >---------

var canTraverseDoor = false
var positionOtherDoor

func approachDoor(position):
	canTraverseDoor = true
	positionOtherDoor = position
	
func leaveDoor():
	canTraverseDoor = false

func tryToTraverseDoor():
	if canTraverseDoor:
		set_position(positionOtherDoor)

#---------<    MOVEMENT STUFF    >---------

func calculateMovement(delta):
	if is_on_floor():
		velocity.y = delta * GRAVITY
	else:
		velocity.y += delta * GRAVITY

	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
	else:
		velocity.x = 0
	move_and_slide(velocity, Vector2(0, -1))

func _physics_process(delta):
	calculateMovement(delta)
	
	if Input.is_action_just_pressed("ui_up"):
		tryToTraverseDoor();	
