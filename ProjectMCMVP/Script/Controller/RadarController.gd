class_name RadarController
extends RefCounted

var worldData: WorldData
var radarData: RadarData

var sweep_width: float = 0.15 

func _init(p_worldData: WorldData, p_radarData: RadarData):
	worldData = p_worldData
	radarData = p_radarData

func update(delta: float):
	radarData.update(delta)
	check_sweep_collision()

func check_sweep_collision():
	var center = Vector2(0.5, 0.5)
	var current_angle = radarData.sweep_angle
	
	for entity in worldData.getEntities():
		if not entity.is_alive: continue
		if not entity is RadarVisibleEntity: continue
			
		var target = entity as RadarVisibleEntity
		if target.is_stealth: continue
		
		# ЕСЛИ ЭТО ВЗРЫВ: не ждем луч, обновляем сразу и пропускаем математику
		if not target.requires_sweep:
			radarData.ping_entity(entity)
			continue 
			
		# ЕСЛИ ЭТО РАКЕТА: делаем математику луча
		var offset = entity.position - center
		var entity_angle = offset.angle()
		
		if entity_angle < 0:
			entity_angle += TAU
			
		var angle_diff = abs(entity_angle - current_angle)
		if angle_diff > PI:
			angle_diff = TAU - angle_diff
			
		if angle_diff < sweep_width:
			radarData.ping_entity(entity)
