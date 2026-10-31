class_name RadarView2D
extends Node2D

var radarData: RadarData

# Настройки луча (меняются в инспекторе)
@export var trail_length: float = 0.6     # Длина хвоста (в радианах)
@export var trail_intensity: float = 0.6  # Яркость хвоста (прозрачность)
@export var core_line_width: float = 2.0  # Толщина главной линии луча

func _process(delta: float):
	queue_redraw()

func _draw():
	if not radarData: return
	
	var screenSize = get_viewport_rect().size
	var center = screenSize / 2
	var radius = screenSize.length() # Берем с запасом, чтобы луч уходил за края
	
	# 1. Рисуем хвост свечения (вызов нашей функции внизу)
	draw_sweep_trail(center, radius)
	
	# 2. Рисуем саму четкую линию луча (голова)
	var line_end = center + Vector2(cos(radarData.sweep_angle), sin(radarData.sweep_angle)) * radius
	draw_line(center, line_end, Color(0.3, 1.0, 0.3, 1.0), core_line_width)
	
	# 3. Рисуем точки-метки
	draw_blips(screenSize)


# --- ФУНКЦИЯ ДЛЯ СВЕЧЕНИЯ (Можешь не читать, просто знай, что она рисует хвост) ---
func draw_sweep_trail(center: Vector2, radius: float):
	var points = PackedVector2Array()
	var colors = PackedColorArray()
	
	# Центр радара (откуда растет луч)
	points.append(center)
	colors.append(Color(0, 1, 0, 0.0)) 
	
	var segments = 15
	var start_angle = radarData.sweep_angle - trail_length
	var end_angle = radarData.sweep_angle
	
	# Строим дугу от хвоста к голове
	for i in range(segments + 1):
		var t = float(i) / segments
		var angle = lerp(start_angle, end_angle, t) 
		var pos = center + Vector2(cos(angle), sin(angle)) * radius
		
		points.append(pos)
		# Плавно увеличиваем яркость к голове луча
		var alpha = t * t * trail_intensity 
		colors.append(Color(0, 1, 0, alpha)) 
		
	# Рисуем всё это как один полигон
	draw_polygon(points, colors)


# --- ФУНКЦИЯ ДЛЯ МЕТОК (Тоже вынесена для чистоты) ---
func draw_blips(screenSize: Vector2):
	var side = min(screenSize.x, screenSize.y)
	
	for entity in radarData.detected_entities:
		var saved_pos = radarData.get_blip_position(entity)
		var screenPos = (screenSize - Vector2(side, side)) / 2 + saved_pos * side
		
		var opacity = radarData.get_blip_opacity(entity)
		var color = Color.RED
		
		if entity is RadarVisibleEntity:
			color = entity.blip_color
			
		color.a = opacity
		
		# Чем старее метка, тем меньше точка
		var point_size = 6.0 * opacity 
		if point_size > 1.0:
			draw_circle(screenPos, point_size, color)
