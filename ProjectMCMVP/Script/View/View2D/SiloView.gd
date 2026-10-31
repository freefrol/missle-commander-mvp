class_name SiloView
extends WorldEntity2D

@export var sprite: Sprite2D
@export var fillSprite: Sprite2D

# Оставляем ссылку для удобства (чтобы не делать каст каждый раз)
var siloData: SiloData

func _ready() -> void:
	# Приводим базовый entity к SiloData
	siloData = entity as SiloData
	
	if siloData:
		siloData.ready.connect(siloReady)
		siloData.destroyed.connect(siloDestroyed)

func siloReady(silo):
	if sprite == null: return
	sprite.modulate = Color.WHITE
	
func siloDestroyed(silo):
	if sprite == null: return
	sprite.modulate = Color.GRAY
	
func _process(delta: float) -> void:
	# 1. Вызываем базовый метод, который двигает вьюху (position = ...)
	super._process(delta)
	
	# 2. Уникальная логика заливки
	if not siloData: return
	var progress = siloData.getReloadProgress()
	var texHeight = fillSprite.texture.get_height()
	var texWidth = fillSprite.texture.get_width()
	
	fillSprite.region_enabled = true
	fillSprite.region_rect = Rect2(0, texHeight * (1 - progress), texWidth, texHeight * progress)
