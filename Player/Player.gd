extends KinematicBody2D

export var GRAVITY = 200.0
export var WALK_SPEED = 250
export var FIX_SPEED = 20

var canFixHole = false
var isNearHole = false
var holeToPatch = null

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
		canFixHole = true
	
	
	if isNearHole and canFixHole and Input.is_action_pressed("ui_select"):
		if holeToPatch.accessible == true:
			holeToPatch.fixPercent += FIX_SPEED * delta
			$FixBar.value = holeToPatch.fixPercent
			if  holeToPatch.fixPercent >= 100:
				holeToPatch.suicide()
				canFixHole = false
				exitHole()

#---------<    CA PATCH DES HOLES PAR ICI    >---------
func _on_HoleDetection_area_entered(area):
	if area.get_parent().accessible == true:
		isNearHole = true
		holeToPatch = area.get_parent()
		if canFixHole:
			$FixBar.value = holeToPatch.fixPercent
			$FixBar.show()
			$CannotFix.hide()
		else:
			$CannotFix.show()
			$FixBar.hide()

func _on_HoleDetection_area_exited(area):
	exitHole()

func exitHole():
	isNearHole = false
	holeToPatch = null
	$FixBar.hide()
	$CannotFix.hide()
