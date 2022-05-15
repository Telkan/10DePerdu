extends KinematicBody2D

export var GRAVITY = 200.0
export var WALK_SPEED = 250
export var FIX_SPEED = 20


var isNearHole = false
var holeToPatch = null



var canAction = false
var actionTarget

var canPickup = false
var pickupTarget



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
		$Sprite.playing = true
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		$Sprite.playing = true
		velocity.x =  WALK_SPEED
	else:
		velocity.x = 0
		$Sprite.playing = false
		$Sprite.frame = 0
	move_and_slide(velocity, Vector2(0, -1))

func _physics_process(delta):
	calculateMovement(delta)
	
	if Input.is_action_just_pressed("ui_up"):
		tryToTraverseDoor();

	
	#Fix Hole
	if isNearHole and Globals.canFixHole and Input.is_action_pressed("ui_select"):
		if holeToPatch.accessible == true:
			$HammerSound.play()
			holeToPatch.fixPercent += FIX_SPEED * delta
			$FixBar.value = holeToPatch.fixPercent
			if  holeToPatch.fixPercent >= 100:
				holeToPatch.suicide()
				Globals.canFixHole = false
				exitHole()
	
	#Trap Stuff
	if canAction == true:
		if "Banana" in actionTarget.name:
			if Globals.hasABanana == true:
				if Input.is_action_pressed("ui_select"):
					actionTarget.setTrap()
					Globals.hasABanana = false
					get_tree().call_group("Prompts","hide")
		if "Screwdriver" in actionTarget.name:
			if Globals.hasScrewdriver == true:
				if Input.is_action_pressed("ui_select"):
					actionTarget.setTrap()
					Globals.hasScrewdriver = false
					get_tree().call_group("Prompts","hide")
					
	#Pickup shit
	if canPickup == true:
		if Input.is_action_pressed("ui_select"):
			if "Banana" in pickupTarget.name:
				if Globals.hasABanana == false and pickupTarget.empty == false:
					Globals.hasABanana = true
					pickupTarget.take()
			elif "Dead" in pickupTarget.name:
				if Globals.canFixHole == false:
					Globals.canFixHole = true
					pickupTarget.take()
			elif "Vendeur" in pickupTarget.name and Globals.Pognon >=40:
				Globals.canUnscrewBarrier = true
				pickupTarget.take()
				Globals.Pognon -= 40
				get_parent().find_node("ScrewdriverTrap").find_node("Screwdriver").setup()
			elif "Screwdriver" in pickupTarget.name  and pickupTarget.empty == false:
				Globals.hasScrewdriver = true
				pickupTarget.take()

	
#---------<    CA PATCH DES HOLES PAR ICI    >---------
func _on_HoleDetection_area_entered(area):
	if area.get_parent().accessible == true:
		isNearHole = true
		holeToPatch = area.get_parent()
		if Globals.canFixHole:
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

#---------<    CA POSE DES PIEGES PAR ICI    >---------
func _on_TrapDetection_area_entered(area):
	#Check which trap it is
	if "Banana" in area.name:
		canAction = true
		actionTarget = area
		if Globals.hasABanana == false:
			$NoBanana.show()
		else :
			$Okay.show()
	elif "Screwdriver" in area.name:
		if Globals.canUnscrewBarrier == false:
			$QMark.show()
		elif Globals.hasScrewdriver == false:
			$NoScrew.show()
		else:
			$Okay.show()
		canAction = true
		actionTarget = area



func _on_TrapDetection_area_exited(area):
	get_tree().call_group("Prompts","hide")
	canAction = false
	pass # Replace with function body.


#---------<    CA PICKUP DES TRUCS PAR ICI    >---------

func _on_PickupDetection_area_entered(area):
	canPickup = true
	pickupTarget = area
	if "Vendeur" in pickupTarget.name:
		pickupTarget.showStuff()
	else: 
		if pickupTarget.empty == false:
			$SpcPrompt.show()


func _on_PickupDetection_area_exited(area):
	canPickup = false
	if "Vendeur" in pickupTarget.name:
		pickupTarget.hideStuff()
	else: 
		$SpcPrompt.hide()
	pass # Replace with function body.
