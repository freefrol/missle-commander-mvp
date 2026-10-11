class_name EnemyMissileView3D

extends Node3D

var missileData: MissileData
var worldSize: float = 20.0

func _process(delta: float):
	if missileData == null: return
	position = Vector3(
		(missileData.position.x - 0.5) * worldSize,
		2.0,
		(missileData.position.y - 0.5) * worldSize
	)
