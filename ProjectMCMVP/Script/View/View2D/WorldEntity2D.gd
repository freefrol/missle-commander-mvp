class_name WorldEntity2D
extends Node2D

var entity: Entity

func _process(delta: float):
	if entity:
		position = getScreenPosition()

# Считает позицию на экране (внутри SubViewport) на основе 2D-координат (0..1)
func getScreenPosition() -> Vector2:
	var screenSize = get_viewport_rect().size
	var side = min(screenSize.x, screenSize.y)
	var offset = (screenSize - Vector2(side, side)) / 2
	return offset + entity.position * side

# Возвращает размер "виртуального квадрата" для расчета радиусов
func getWorldSide() -> float:
	var screenSize = get_viewport_rect().size
	return min(screenSize.x, screenSize.y)
