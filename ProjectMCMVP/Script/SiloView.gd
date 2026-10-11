class_name SiloView
extends Node2D

@export var sprite: Sprite2D
@export var fillSprite: Sprite2D
var siloData : SiloData

func _ready() -> void:
	siloData.ready.connect(siloReady)
	siloData.destroyed.connect(siloDestroed)
	
func siloReady(silo):
	if sprite == null: return
	sprite.modulate = Color.WHITE
	
func siloDestroed(silo):
	if sprite == null: return
	sprite.modulate = Color.GRAY
	
func _process(delta: float) -> void:
	var screenSize = get_viewport_rect().size
	var side = min(screenSize.x, screenSize.y)
	var offset = (screenSize - Vector2(side, side)) / 2
	position = offset + siloData.position * side
	
	var progress = siloData.getReloadProgress()
	var texHeight = fillSprite.texture.get_height()
	var texWidth = fillSprite.texture.get_width()
	
	fillSprite.region_enabled = true
	fillSprite.region_rect = Rect2(0, texHeight * (1 - progress), texWidth, texHeight * progress)
