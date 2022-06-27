extends Node2D

# Global Variables
export(int) var _score: int = 0
export(int) var _speed: int = 5
export(bool) var _rotate: bool = false
onready var _animSprite: AnimatedSprite = $AnimatedSPrite
onready var _rb: RigidBody2D = $RigidBody2D
onready var _collisionShape: CollisionShape2D = $CollisionShape2D
var _randGenerate: RandomNumberGenerator = RandomNumberGenerator.new()

# Engine Functions
func _ready():
	_randGenerate.randomize()
	pass

func _physics_process(delta):
	position.y += _speed
	
	if _rotate:
		rotate(_randGenerate.randf_range(0.003,0.05))
	
	if position.y > 850:
		queue_free()
	
	pass
