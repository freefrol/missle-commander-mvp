class_name RadarData
extends RefCounted

var sweep_angle: float = 0.0
var sweep_speed: float = 1.57 
var max_fade_time: float = 3.0 # Запасное время, если у сущности не задано

# Теперь храним: Entity -> { "time": float, "pos": Vector2 }
var detected_entities: Dictionary = {}

func update(delta: float):
	sweep_angle += sweep_speed * delta
	if sweep_angle >= TAU:
		sweep_angle -= TAU
		
	var to_remove: Array = []
	
	for entity in detected_entities.keys():
		detected_entities[entity]["time"] += delta
		
		# Берем время затухания из самой сущности (у ракет 3.0, у взрывов 0.5)
		var f_time = max_fade_time
		if entity is RadarVisibleEntity:
			f_time = entity.fade_time
			
		if detected_entities[entity]["time"] >= f_time:
			to_remove.append(entity)
			
	for entity in to_remove:
		detected_entities.erase(entity)

func ping_entity(entity: Entity):
	# Сохраняем время и позицию на момент обнаружения
	detected_entities[entity] = {
		"time": 0.0,
		"pos": entity.position
	}

func get_blip_opacity(entity: Entity) -> float:
	if not detected_entities.has(entity): return 0.0
	var time_passed = detected_entities[entity]["time"]
	
	var f_time = max_fade_time
	if entity is RadarVisibleEntity:
		f_time = entity.fade_time
		
	return 1.0 - (time_passed / f_time)

func get_blip_position(entity: Entity) -> Vector2:
	if detected_entities.has(entity):
		return detected_entities[entity]["pos"]
	return Vector2.ZERO
