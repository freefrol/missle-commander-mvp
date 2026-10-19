class_name WorldEntity3D
extends Node3D

var worldBounds: WorldBounds

# Перемещает вьюху в 3D на основе её 2D позиции
func updatePosition(pos2D: Vector2):
	if worldBounds:
		global_position = worldBounds.map2DTo3D(pos2D)

# Возвращает масштаб для взрывов с учетом размера мира
func getScaledRadius(radius2D: float, multiplier: float = 1.0) -> float:
	if worldBounds:
		return radius2D * worldBounds.getWorldScale() * multiplier
	return radius2D * 20.0 * multiplier # fallback, если мира нет
