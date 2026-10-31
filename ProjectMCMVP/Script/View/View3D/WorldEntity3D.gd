class_name WorldEntity3D
extends Node3D

var entity: Entity       # Ссылка на любые данные (ракета, город, шахта, взрыв)
var worldBounds: WorldBounds

func _process(delta: float):
	# Если данные и границы мира заданы — обновляем позицию
	if entity and worldBounds:
		global_position = worldBounds.map2DTo3D(entity.position)

# Вспомогательный метод для взрывов, чтобы не дублировать формулу масштаба
func getScaledRadius(radius2D: float, multiplier: float = 1.0) -> float:
	if worldBounds:
		return radius2D * worldBounds.getWorldScale() * multiplier
	return radius2D * 20.0 * multiplier # Запасной вариант, если границы не заданы
