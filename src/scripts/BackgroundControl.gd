extends Node2D

# Imports
const Enums = preload("res://src/scripts/Enums.gd")
onready var Game = get_node("..")

# Global Variables
onready var RollOne: Node2D = $roller01
onready var RollTwo: Node2D = $roller02
export(int) var BackgroundSpeed: int = 5
var Seconds: float = 0
var TransTroposToStratos: bool = true
var TransStratosToMesos: bool = true
var TransMesosToThermos: bool = true
var TransThermosToExos: bool = true
var TransExosToSpace: bool = true
var AlreadyShowedMoon: bool = false
var AlreadyShowedMars: bool = false
var RandGenerate: RandomNumberGenerator = RandomNumberGenerator.new()

# Private Functions
func getFrame(currentAtmosphere: int) -> int:
	var randomValue: int = 0
	
	if currentAtmosphere == Enums.Atmosphere.Stratosphere:
		if self.TransTroposToStratos:
			randomValue = 12
			self.TransTroposToStratos = false
		else:
			randomValue = self.RandGenerate.randi_range(10, 11)
	elif currentAtmosphere == Enums.Atmosphere.Mesosphere:
		if self.TransStratosToMesos:
			randomValue = 9
			self.TransStratosToMesos = false
		else:
			randomValue = 8
	elif currentAtmosphere == Enums.Atmosphere.Thermosphere:
		if self.TransMesosToThermos:
			randomValue = 7
			self.TransMesosToThermos = false
		else:
			randomValue = 6
	elif currentAtmosphere == Enums.Atmosphere.Exosphere:
		if self.TransThermosToExos:
			randomValue = 5
			self.TransThermosToExos = false
		else:
			randomValue = 4
	elif currentAtmosphere == Enums.Atmosphere.Space:
		if self.TransExosToSpace:
			randomValue = 3
			self.TransExosToSpace = false
		else:
			if round(self.Seconds) > 30 and !self.AlreadyShowedMoon:
				self.AlreadyShowedMoon = true
				randomValue = 1
			elif round(self.Seconds) > 35 and !self.AlreadyShowedMars:
				self.AlreadyShowedMars = true
				randomValue = 0
			else:
				randomValue = 2
	else:
		randomValue = self.RandGenerate.randi_range(13, 15)
	return randomValue

func checkAndMoveSprite(node) -> void:
	if node.position > Vector2(0, 774):
		node.frame = getFrame(Game.CurrentAtmosphere)
		node.position = Vector2(0, -775)

# Engine Functions
func _ready():
	self.RandGenerate.randomize()
	pass

func _process(delta):
	self.Seconds += delta
	
	checkAndMoveSprite(self.RollOne)
	checkAndMoveSprite(self.RollTwo)
	self.RollOne.move_local_y(self.BackgroundSpeed)
	self.RollTwo.move_local_y(self.BackgroundSpeed)
		
	pass
