class_name PlayerMissileView3d

extends Node3D

var missileData: PlayerMissileData
var worldSize: float = 20.0

func _process(delta: float):
	if missileData == null: return
	position = Vector3(
		(missileData.position.x - 0.5) * worldSize,
		-(missileData.position.y - 0.5) * worldSize,
		-20.0
	)
