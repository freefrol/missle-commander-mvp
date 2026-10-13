class_name PlayerController

extends CharacterBody3D

@export var cameraPivot: Node3D
@export var moveSpeed : float = 0.1
@export var turnSpeed : float = 0.1

func move(direction : Vector2):
	velocity.x = moveSpeed * direction.x
	velocity.z = moveSpeed * direction.y
	
func _process(delta: float) -> void:
	move(Vector2(0, -1))
	move_and_slide()

func _input(event):
	if event is InputEventScreenDrag:
		rotation.y -= turnSpeed * event.relative.x
		cameraPivot.rotation.x -= turnSpeed * event.relative.y
		cameraPivot.rotation.x = clamp(cameraPivot.rotation.x, -1.4, 1.4)
