class_name WorldBounds
extends Node3D

@export var visual: MeshInstance3D

# Переводит 2D-координату (0..1) в 3D-позицию на этом квадрате
func map2DTo3D(pos: Vector2) -> Vector3:
	# pos.x: 0..1, pos.y: 0..1
	# Локальные координаты квадрата 1x1 идут от -0.5 до 0.5
	# По Y инвертируем, так как в 3D Y растёт вверх, а в 2D Y растёт вниз
	var localPos = Vector3(pos.x - 0.5, 0.5 - pos.y, 0)
	return visual.global_transform * localPos

# Возвращает масштаб мира (чтобы взрывы были правильного размера)
func getWorldScale() -> float:
	return abs(visual.global_transform.basis.get_scale().x)
