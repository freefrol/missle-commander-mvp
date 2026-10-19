class_name EnemyMissileView3D

extends WorldEntity3D

var missileData: MissileData

func _process(delta: float):
	if missileData == null: return
	updatePosition(missileData.position)
