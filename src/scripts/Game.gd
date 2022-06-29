extends Node

# Imports
const Enums = preload("res://src/scripts/Enums.gd")

# Global Variables
var Seconds: float = 0
var Score = 0
var Health = 0
var CurrentAtmosphere = Enums.Atmosphere.Troposphere

# Private Functions
func updateAtmosphere() -> void:
	var at = null
	if round(self.Seconds) == 2:
		at = Enums.Atmosphere.Stratosphere
	elif round(self.Seconds) == 5:
		at = Enums.Atmosphere.Mesosphere
	elif round(self.Seconds) == 8:
		at = Enums.Atmosphere.Thermosphere
	elif round(self.Seconds) == 11:
		at = Enums.Atmosphere.Exosphere
	elif round(self.Seconds) == 15:
		at = Enums.Atmosphere.Space
	if at != null:
		self.CurrentAtmosphere = at

# Engine Functions
func _ready():
	self.Health = 3
	pass

func _process(delta):
	self.Seconds += delta
	updateAtmosphere()
