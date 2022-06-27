extends Node2D

# Imports
const Enums = preload("res://src/scripts/Enums.gd")

# Global Variables
onready var Global = get_node("/root/Global")
onready var _rollOne: Node2D = $roller01
onready var _rollTwo: Node2D = $roller02
export(int) var _backgroundSpeed: int = 5
var _seconds: float = 0
var _transTroposToStratos: bool = true
var _transStratosToMesos: bool = true
var _transMesosToThermos: bool = true
var _transThermosToExos: bool = true
var _transExosToSpace: bool = true
var _alreadyShowedMoon: bool = false
var _alreadyShowedMars: bool = false
var _randGenerate: RandomNumberGenerator = RandomNumberGenerator.new()

# Private Functions
func getFrame(currentAtmosphere: int) -> int:
	var randomValue: int = 0
	
	if currentAtmosphere == Enums.Atmosphere.Stratosphere:
		if _transTroposToStratos:
			randomValue = 12
			_transTroposToStratos = false
		else:
			randomValue = _randGenerate.randi_range(10, 11)
	elif currentAtmosphere == Enums.Atmosphere.Mesosphere:
		if _transStratosToMesos:
			randomValue = 9
			_transStratosToMesos = false
		else:
			randomValue = 8
	elif currentAtmosphere == Enums.Atmosphere.Thermosphere:
		if _transMesosToThermos:
			randomValue = 7
			_transMesosToThermos = false
		else:
			randomValue = 6
	elif currentAtmosphere == Enums.Atmosphere.Exosphere:
		if _transThermosToExos:
			randomValue = 5
			_transThermosToExos = false
		else:
			randomValue = 4
	elif currentAtmosphere == Enums.Atmosphere.Space:
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

func checkAndMoveSprite(node) -> void:
	if node.position > Vector2(0, 774):
		node.frame = getFrame(Global.InGame.CurrentAtmosphere)
		node.position = Vector2(0, -775)

# Engine Functions
func _ready():
	_randGenerate.randomize()
	pass

func _process(delta):
	_seconds += delta
	
	checkAndMoveSprite(_rollOne)
	checkAndMoveSprite(_rollTwo)
	_rollOne.move_local_y(_backgroundSpeed)
	_rollTwo.move_local_y(_backgroundSpeed)
		
	pass
