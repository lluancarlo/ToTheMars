extends Node

# Imports
const Enums = preload("res://src/scripts/Enums.gd")
# Editor
export (float) var maxBackgroundSpeed = 9.9
# Global
var BackgroundSpeed: float = 0
var RocketLaunched: bool = false
var GameSeconds: float = 0
var Score: int = 0
var Health: int = 0
var CurrentAtmosphere = Enums.Atmosphere.Troposphere

# Private Functions
func updateAtmosphere(seconds: float) -> void:
	var at = null
	if round(seconds) == 5:
		at = Enums.Atmosphere.Stratosphere
	elif round(seconds) == 20:
		at = Enums.Atmosphere.Mesosphere
	elif round(seconds) == 32:
		at = Enums.Atmosphere.Thermosphere
	elif round(seconds) == 60:
		at = Enums.Atmosphere.Exosphere
	elif round(seconds) == 120:
		at = Enums.Atmosphere.Space
	if at != null:
		self.CurrentAtmosphere = at

# Engine Functions
func _ready():
	self.Health = 3
	pass

func _process(delta: float):
	if self.RocketLaunched:
		if self.BackgroundSpeed < self.maxBackgroundSpeed:
			self.BackgroundSpeed += 0.1
		self.GameSeconds += delta
		updateAtmosphere(self.GameSeconds)
