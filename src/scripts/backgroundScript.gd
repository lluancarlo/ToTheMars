extends Node2D

onready var RollOne = $roller01
onready var RollTwo = $roller02

enum ATMOSPHERE{
	troposphere = 1,
	stratosphere = 2,
	mesosphere = 3,
	thermosphere = 4,
	exosphere = 5,
	space = 6
}

export(int) var _backgroundSpeed = 5
var _seconds = 0
var _currentAtmosphere = ATMOSPHERE.troposphere
var _transTroposToStratos = true
var _transStratosToMesos = true
var _transMesosToThermos = true
var _transThermosToExos = true
var _transExosToSpace = true
var _alreadyShowedMoon = false
var _alreadyShowedMars = false
var _randGenerate = RandomNumberGenerator.new()

func updateAtmosphere():
	if round(_seconds) == 5:
		_currentAtmosphere = ATMOSPHERE.stratosphere
	elif round(_seconds) == 10:
		_currentAtmosphere = ATMOSPHERE.mesosphere
	elif round(_seconds) == 15:
		_currentAtmosphere = ATMOSPHERE.thermosphere
	elif round(_seconds) == 20:
		_currentAtmosphere = ATMOSPHERE.exosphere
	elif round(_seconds) == 25:
		_currentAtmosphere = ATMOSPHERE.space
	pass
	
func getFrame():
	var randomValue = 0
	
	if _currentAtmosphere == ATMOSPHERE.stratosphere:
		if _transTroposToStratos:
			randomValue = 12
			_transTroposToStratos = false
		else:
			randomValue = _randGenerate.randi_range(10, 11)
	elif _currentAtmosphere == ATMOSPHERE.mesosphere:
		if _transStratosToMesos:
			randomValue = 9
			_transStratosToMesos = false
		else:
			randomValue = 8
	elif _currentAtmosphere == ATMOSPHERE.thermosphere:
		if _transMesosToThermos:
			randomValue = 7
			_transMesosToThermos = false
		else:
			randomValue = 6
	elif _currentAtmosphere == ATMOSPHERE.exosphere:
		if _transThermosToExos:
			randomValue = 5
			_transThermosToExos = false
		else:
			randomValue = 4
	elif _currentAtmosphere == ATMOSPHERE.space:
		if _transExosToSpace:
			randomValue = 3
			_transExosToSpace = false
		else:
			if round(_seconds) > 30 and !_alreadyShowedMoon:
				_alreadyShowedMoon = true
				randomValue = 1
			elif round(_seconds) > 35 and !_alreadyShowedMars:
				_alreadyShowedMars = true
				randomValue = 0
			else:
				randomValue = 2
	else:
		randomValue = _randGenerate.randi_range(13, 15)
	
	return randomValue

func checkAndMoveSprite(node):
	if node.position > Vector2(0, 774):
		node.frame = getFrame()
		node.position = Vector2(0, -775)

func _ready():
	_randGenerate.randomize()
	pass

func _process(delta):
	_seconds += delta
	
	checkAndMoveSprite(RollOne)
	checkAndMoveSprite(RollTwo)
	RollOne.move_local_y(_backgroundSpeed)
	RollTwo.move_local_y(_backgroundSpeed)
	updateAtmosphere()
		
	pass
