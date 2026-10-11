class_name ExplosionView
extends Node2D

var explosionData: ExplosionData

func _process(delta: float) -> void:
	if explosionData == null:
		return
	queue_redraw()

func _draw() -> void:
	if explosionData == null:
		return
	
	var screenSize = get_viewport_rect().size
	var side = min(screenSize.x, screenSize.y)
	var offset = (screenSize - Vector2(side, side)) / 2
	
	var screenPos = offset + explosionData.position * side
	var screenRadius = explosionData.currentRadius * side
	
	draw_circle(screenPos, screenRadius, Color(1, 0.5, 0, 0.6))
