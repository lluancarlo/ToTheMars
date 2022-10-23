extends KinematicBody2D

# Imports
const Enums = preload("res://src/scripts/Enums.gd")
onready var Game = get_node("..")
# Nodes
onready var ParticleFire: Particles2D = $Particles2D
# Editor
export (int) var Speed = 300
export (int) var MaxRotationDegree = 7
export (float) var MaxRotationSpeed = 0.7
export (int) var ScreenBorderToMove = 50
# Global
var Velocity: Vector2 = Vector2()
var RotationDegree: float = 0

# Events Functions
func _on_Area2D_body_entered(body: Node2D):
	if body.is_in_group("NegativeItens"):
		print("COLIDIU em " + str(body.global_position))
	pass
	
# Private Functions
func get_input():
	# Moving
	self.Velocity = Vector2()
	if Input.is_action_pressed("game_right"):
		if self.position.x < get_viewport().size.x - self.ScreenBorderToMove:
			self.Velocity.x += 1
	if Input.is_action_pressed("game_left"):
		if self.position.x > self.ScreenBorderToMove:
			self.Velocity.x -= 1
	self.Velocity = self.Velocity.normalized() * self.Speed
	move_and_slide(self.Velocity)

func get_rotation_degrees():
	if self.Velocity.x > 0 and self.RotationDegree < self.MaxRotationDegree:
		self.RotationDegree += self.MaxRotationSpeed
	elif self.Velocity.x < 0 and self.RotationDegree > -self.MaxRotationDegree:
		self.RotationDegree -= self.MaxRotationSpeed
	elif self.Velocity.x == 0:
		if self.RotationDegree > 0:
			self.RotationDegree -= self.MaxRotationSpeed
		else:
			self.RotationDegree += self.MaxRotationSpeed
	self.rotation_degrees = self.RotationDegree

# Engine Functions
func _physics_process(delta):
	if Input.is_action_pressed("game_launch"):
		self.Game.RocketLaunched = true
		self.ParticleFire.emitting = true
	
	if self.Game.RocketLaunched:
		get_input()
		get_rotation_degrees()
		
	# Turn of the fire on space
	if self.Game.CurrentAtmosphere == Enums.Atmosphere.Space:
		self.ParticleFire.emitting = false
