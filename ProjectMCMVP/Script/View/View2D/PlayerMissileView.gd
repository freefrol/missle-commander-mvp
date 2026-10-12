class_name PlayerMissileView
extends Node2D

var playerMissileData : PlayerMissileData


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playerMissileData == null:
		return
	
	var screenSize = get_viewport_rect().size
	var side = min(screenSize.x, screenSize.y)
	var offset = (screenSize - Vector2(side, side)) / 2

	var screenPos = offset + playerMissileData.position * side
	position = screenPos
