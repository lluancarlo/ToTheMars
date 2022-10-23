extends Node2D

# Imports
const Enums = preload("res://src/scripts/Enums.gd")
onready var Game = get_node("..")
# Editor
export(Resource) var Meteorite = null
export(Resource) var MeteoriteHitParticle = null
# Global
var RandGenerate = RandomNumberGenerator.new()
var TimerItens = null

func teste(body: Node2D):
	if body.is_in_group("Player"):
		print("Colidiu em " + str(body.name))
		var particle: Particles2D = self.MeteoriteHitParticle.instance()
		particle.local_coords = false
	pass
	
# Private Functions
func genMeteorite():
	if self.Meteorite != null:
		var item: RigidBody2D = self.Meteorite.instance()
		
		# Random position
		item.position.x = self.RandGenerate.randi_range(30,1250)
		item.position.y = -50
		
		var area = item.get_node("Area2D")
		area.connect("body_entered", self, "teste")
		
		# Random velocity and rotation
		item.linear_velocity = Vector2(self.RandGenerate.randi_range(-100,100), self.RandGenerate.randi_range(30,300))
		item.angular_velocity = self.RandGenerate.randf_range(0.5,7.5)
		
		# Random sprite
		var animSprite: AnimatedSprite = item.get_node("AnimatedSprite")
		var frameCount: int = animSprite.frames.get_frame_count("default")
		animSprite.frame = self.RandGenerate.randi_range(1, frameCount)
		
		add_child(item)
		
func spawnItem():
	if self.Game.CurrentAtmosphere == self.Enums.Atmosphere.Space:
		genMeteorite()
		self.Game.Score += 1

# Engine Functions
func _ready():
	self.RandGenerate.randomize()
	self.TimerItens = Timer.new()
	add_child(self.TimerItens)

	self.TimerItens.connect("timeout", self, "spawnItem")
	self.TimerItens.set_wait_time(2.0)
	self.TimerItens.start()
	pass
