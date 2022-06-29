extends Node2D

# Imports
const Enums = preload("res://src/scripts/Enums.gd")
onready var Game = get_node("..")

# Global Variable
export(PackedScene) var Meteorite = null
var Seconds: float = 0.0
var RandGenerate = RandomNumberGenerator.new()
var TimerItens = null

# Private Functions
func genMeteorite():
	if self.Meteorite != null:
		var item = self.Meteorite.instance()
		item.position.x = self.RandGenerate.randi_range(30,1250)
		item.position.y = -100
		add_child(item)
		
func spawnItem():
	if Game.CurrentAtmosphere == Enums.Atmosphere.Space:
		genMeteorite()
		Game.Score += 1

# Engine Functions
func _ready():
	self.RandGenerate.randomize()
	self.TimerItens = Timer.new()
	add_child(self.TimerItens)

	self.TimerItens.connect("timeout", self, "spawnItem")
	self.TimerItens.set_wait_time(2.0)
	self.TimerItens.start()
	pass
	
func _physics_process(delta):
	self.Seconds += delta
	pass
