extends KinematicBody2D

export (int) var _speed = 200
var _velocity = Vector2()

func get_input():
	_velocity = Vector2()
	if Input.is_action_pressed("game_right"):
		_velocity.x += 1
	if Input.is_action_pressed("game_left"):
		_velocity.x -= 1
#	if Input.is_action_pressed("game_down"):
#		_velocity.y += 1
#	if Input.is_action_pressed("game_up"):
#		_velocity.y -= 1
	_velocity = _velocity.normalized() * _speed

func _ready():
	pass

func _physics_process(delta):
	get_input()
	_velocity = move_and_slide(_velocity)
