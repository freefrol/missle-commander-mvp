class_name MissileView
extends Node2D

var missileData : MissileData


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if missileData == null:
		return
		
	var screenSize = get_viewport_rect().size
	var side = min(screenSize.x, screenSize.y)
	var offset = (screenSize - Vector2(side, side)) / 2

	var screenPos = offset + missileData.position * side
	position = screenPos
	#position = missileData.position * screenPos
