extends Node

enum State {MOVING, IDLING, WAITING, FALLING}

var timeToNextScreen = 120
var currentTime = 0
var Pognon = 0
var nbOfHoles = 0

var SpeedOfRocks = 30

#UNLOCKABLES AND STUFF

var canUnscrewBarrier = false

var hasABanana = false

var canFixHole = false

var hasScrewdriver = false
