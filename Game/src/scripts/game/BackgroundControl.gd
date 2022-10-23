extends Node2D

# Imports
const Enums = preload("res://src/scripts/Enums.gd")
onready var Game = get_node("..")
# Nodes
onready var RollOne: AnimatedSprite = $roller01
onready var RollTwo: AnimatedSprite = $roller02
onready var RollThree: AnimatedSprite = $roller03
onready var LaunchPad: Sprite = $launchpad
onready var SmokePad1: Particles2D = $launchpad/SmokeRight
onready var SmokePad2: Particles2D = $launchpad/SmokeLeft
# Global
var TransTroposToStratos: bool = true
var TransStratosToMesos: bool = true
var TransMesosToThermos: bool = true
var TransThermosToExos: bool = true
var TransExosToSpace: bool = true
var AlreadyShowedMoon: bool = false
var AlreadyShowedMars: bool = false
var RandGenerate: RandomNumberGenerator = RandomNumberGenerator.new()
var TimerBackground = null

# Private Functions
func getFrame(currentAtmosphere: int) -> int:
	var randomValue: int = 0
	
	if currentAtmosphere == Enums.Atmosphere.Stratosphere:
		if self.TransTroposToStratos:
			self.LaunchPad.queue_free()
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
			if round(self.Game.GameSeconds) > 300 and !self.AlreadyShowedMoon:
				self.AlreadyShowedMoon = true
				randomValue = 1
			elif round(self.Game.GameSeconds) > 600 and !self.AlreadyShowedMars:
				self.AlreadyShowedMars = true
				randomValue = 0
			else:
				randomValue = 2
	else:
		randomValue = self.RandGenerate.randi_range(13, 15)
	return randomValue

func checkAndMoveSprite(node: Node2D) -> void:
	if node.position.y > 600:
		node.frame = getFrame(Game.CurrentAtmosphere)
		node.position.y -= 1800
		print(node.position.y)
	
# Engine Functions
func _ready():
	self.RandGenerate.randomize()
	pass

func _process(delta: float):
	if self.Game.RocketLaunched:
		# Background Sprites Manager
		checkAndMoveSprite(self.RollOne)
		checkAndMoveSprite(self.RollTwo)
		checkAndMoveSprite(self.RollThree)
		self.RollOne.move_local_y(self.Game.BackgroundSpeed)
		self.RollTwo.move_local_y(self.Game.BackgroundSpeed)
		self.RollThree.move_local_y(self.Game.BackgroundSpeed)
		# Execute just if exist LaunchPad instance
		if weakref(self.LaunchPad).get_ref():
			if self.SmokePad1.emitting:
				self.SmokePad1.emitting = false
			if self.SmokePad2.emitting:
				self.SmokePad2.emitting = false
			self.LaunchPad.move_local_y(self.Game.BackgroundSpeed)
		
	pass
