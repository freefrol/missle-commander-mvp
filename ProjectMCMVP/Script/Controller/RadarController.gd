class_name RadarController
extends RefCounted

var worldData: WorldData
var radarData: RadarData

# Ширина луча в радианах (чем больше, тем толще луч и легче поймать цель)
var sweep_width: float = 0.15 

func _init(p_worldData: WorldData, p_radarData: RadarData):
	worldData = p_worldData
	radarData = p_radarData

func update(delta: float):
	# 1. Обновляем саму модель радара (крутим луч, обновляем таймеры затухания)
	radarData.update(delta)
	
	# 2. Проверяем, не попал ли луч в кого-нибудь
	check_sweep_collision()

func check_sweep_collision():
	# Центр радара (в координатах 2D мира это всегда 0.5, 0.5)
	var center = Vector2(0.5, 0.5)
	var current_angle = radarData.sweep_angle
	
	# Проходимся по всем сущностям в мире
	for entity in worldData.getEntities():
		# 1. Пропускаем мертвых
		if not entity.is_alive: 
			continue
			
		# 2. Нас интересуют только те, кто в принципе виден радару
		# (Благодаря этому проверка не сломается, когда появятся самолеты)
		if not entity is RadarVisibleEntity: 
			continue
			
		# Приводим тип, чтобы получить доступ к is_stealth
		var radar_target = entity as RadarVisibleEntity
		
		# 3. СТЕЛС! Если цель скрыта, луч проходит мимо
		if radar_target.is_stealth: 
			continue
			
		# 4. Математика обнаружения
		# Вычисляем угол от центра радара до цели
		var offset = entity.position - center
		var entity_angle = offset.angle() # Возвращает от -PI до PI
		
		# Переводим угол в положительное значение (от 0 до TAU)
		if entity_angle < 0:
			entity_angle += TAU
			
		# Проверяем, пересек ли луч цель
		var angle_diff = abs(entity_angle - current_angle)
		
		# Обработка "шва" круга (переход от 0 к TAU)
		if angle_diff > PI:
			angle_diff = TAU - angle_diff
			
		# Если разница меньше ширины луча — мы её нашли!
		if angle_diff < sweep_width:
			radarData.ping_entity(entity)
