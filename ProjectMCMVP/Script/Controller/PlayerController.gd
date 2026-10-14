class_name PlayerController

extends CharacterBody3D

@export var moveJoystick: StickControl
@export var lookJoystick: StickControl
@export var cameraPivot: Node3D
@export var moveSpeed : float = 0.1
@export var turnSpeed : float = 0.1

func move(direction : Vector2):
	velocity.x = moveSpeed * direction.x
	velocity.z = moveSpeed * direction.y
	

func _physics_process(delta):
	move(moveJoystick.direction)
	move_and_slide()
	
	rotation.y -= turnSpeed * lookJoystick.direction.x
	cameraPivot.rotation.x -= turnSpeed * lookJoystick.direction.y
	cameraPivot.rotation.x = clamp(cameraPivot.rotation.x, -1.4, 1.4)
