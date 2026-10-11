class_name CityView
extends Node2D

var cityData: CityData


func _process(delta: float) -> void:
	var screenSize = get_viewport_rect().size
	var side = min(screenSize.x, screenSize.y)
	var offset = (screenSize - Vector2(side, side)) / 2
	position = offset + cityData.position * side
