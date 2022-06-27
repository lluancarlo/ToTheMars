extends Node

# Imports
const Enums = preload("res://src/scripts/Enums.gd")

# Global Variables
onready var Global = get_node("/root/Global")
var _seconds: float = 0

# Private Functions
func updateAtmosphere() -> void:
	var at = null
	if round(_seconds) == 2:
		at = Enums.Atmosphere.Stratosphere
	elif round(_seconds) == 5:
		at = Enums.Atmosphere.Mesosphere
	elif round(_seconds) == 8:
		at = Enums.Atmosphere.Thermosphere
	elif round(_seconds) == 11:
		at = Enums.Atmosphere.Exosphere
	elif round(_seconds) == 15:
		at = Enums.Atmosphere.Space
	if at != null:
		Global.InGame.CurrentAtmosphere = at

# Engine Functions
func _ready():
	pass

func _process(delta):
	_seconds += delta
	updateAtmosphere()
