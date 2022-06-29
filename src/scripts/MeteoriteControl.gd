extends Node2D

# Global Variables
export(int) var ScoreValue: int = 0
export(int) var Speed: int = 5
export(bool) var Rotate: bool = false
onready var AnimSprite: AnimatedSprite = $AnimatedSPrite
onready var Rb: RigidBody2D = $RigidBody2D
onready var CollisionShape: CollisionShape2D = $CollisionShape2D
var RandGenerate: RandomNumberGenerator = RandomNumberGenerator.new()

# Engine Functions
func _ready():
	self.RandGenerate.randomize()
	pass

func _physics_process(delta):
	position.y += self.Speed
	
	if self.Rotate:
		rotate(self.RandGenerate.randf_range(0.003,0.05))
	
	if position.y > 850:
		queue_free()
	
	pass
