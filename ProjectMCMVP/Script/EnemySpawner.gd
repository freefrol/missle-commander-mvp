class_name EnemySpawner
extends RefCounted

var world_data: WorldData

var spawn_interval: float = 1.5
var speed: float = 0.1
var spawn_y_offset: float = 0.1
var explodeY: float = 0.9
var min_angle: float = 0
var max_angle: float = 10
var timer: float = 0.0
var isGameStop : bool = false

func _init(p_world_data: WorldData):
	world_data = p_world_data
		
func update(delta: float):
	if isGameStop : return
	
	timer += delta
	if timer >= spawn_interval:
		timer = 0.0
		spawn()
				
func spawn():
	var start_x = randf_range(0, 1)
	var start_y =  0 - spawn_y_offset
	var start = Vector2(start_x, start_y)
									
	# Сторона: слева → вправо (+1), справа → влево (-1)
	var side = 1 if start_x < 0.5 else -1
												
	# Угол в градусах
	var angle_deg = randf_range(min_angle, max_angle) * side
	var angle_rad = deg_to_rad(angle_deg)
	var direction = Vector2(sin(angle_rad), cos(angle_rad)).normalized()
						
	var missile = MissileData.new(start, direction, speed, explodeY)
	world_data.addEntity(missile)
