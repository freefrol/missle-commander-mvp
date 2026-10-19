class_name PlayerMissileView3d

extends WorldEntity3D

var missileData: PlayerMissileData

func _process(delta: float):
	if missileData == null: return
	
	updatePosition(missileData.position)
