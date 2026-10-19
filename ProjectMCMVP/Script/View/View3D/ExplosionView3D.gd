class_name ExplosionView3D
extends WorldEntity3D

@export var radiusMultiplier : float= 1.0
var explosionData: ExplosionData

func _process(delta: float):
	if explosionData == null:
		return
	
	updatePosition(explosionData.position)
		
	var r = getScaledRadius(explosionData.currentRadius, radiusMultiplier)
	scale = Vector3.ONE * r
