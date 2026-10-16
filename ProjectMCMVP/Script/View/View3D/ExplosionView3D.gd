class_name ExplosionView3D
extends Node3D

var explosionData: ExplosionData
@export var worldSize: float = 20.0

func _process(delta: float):
	if explosionData == null:
		return
	
	position = Vector3(
		(explosionData.position.x - 0.5) * worldSize,
		-(explosionData.position.y - 0.5) * worldSize,
		-20.0
	)
	
	var r = explosionData.currentRadius * worldSize
	scale = Vector3.ONE * r
