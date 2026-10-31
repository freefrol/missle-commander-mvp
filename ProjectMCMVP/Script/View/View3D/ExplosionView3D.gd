class_name ExplosionView3D
extends WorldEntity3D

@export var radiusMultiplier: float = 1.0

func _process(delta: float):
	# 1. Сначала вызываем базовый _process, чтобы вьюха встала на нужную позицию
	super._process(delta)
	
	# 2. Затем добавляем уникальное поведение взрыва — изменение размера
	if entity is ExplosionData:
		var explosion = entity as ExplosionData
		var r = getScaledRadius(explosion.currentRadius, radiusMultiplier)
		scale = Vector3.ONE * r
