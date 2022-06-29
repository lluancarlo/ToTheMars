extends KinematicBody2D

export (int) var Speed = 200
var Velocity = Vector2()

func get_input():
	self.Velocity = Vector2()
	if Input.is_action_pressed("game_right"):
		self.Velocity.x += 1
	if Input.is_action_pressed("game_left"):
		self.Velocity.x -= 1
	self.Velocity = self.Velocity.normalized() * self.Speed

func _ready():
	pass

func _physics_process(delta):
	get_input()
	self.Velocity = move_and_slide(self.Velocity)
