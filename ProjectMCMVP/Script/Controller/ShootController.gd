class_name ShootController
extends Node2D

@export var missileSpeed: float = 0.1
@export var camera: Camera3D
@export var monitor: StaticBody3D
@export var monitorSize: Vector2 = Vector2(1, 1)

var siloController: SiloController
var worldData: WorldData
var isGameStop: bool = false

func _input(event):
	if isGameStop: return
	if not event is InputEventScreenTouch or not event.pressed:
		return
	
	var hitPos = raycastMonitor(event.position)
	if hitPos == null: return
	
	var clickPos = worldToUV(hitPos)
	shoot(clickPos)

# Пускает луч из камеры и возвращает точку попадания в монитор (или null)
func raycastMonitor(screenPos: Vector2):
	var from = camera.project_ray_origin(screenPos)
	var to = from + camera.project_ray_normal(screenPos) * 1000.0
	
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var hit = camera.get_world_3d().direct_space_state.intersect_ray(query)
	
	if hit.is_empty(): return null
	if hit.collider != monitor: return null
	
	return hit.position

# Переводит точку в мире в UV-координаты монитора (0..1)
func worldToUV(worldPos: Vector3) -> Vector2:
	var local = monitor.to_local(worldPos)
	return Vector2(
		local.x / monitorSize.x + 0.5,
		0.5 - local.y / monitorSize.y
	)

func shoot(clickPos: Vector2):
	var silo = siloController.getNearestReadySilo(clickPos)
	if silo == null: return
	
	var missile = PlayerMissileData.new(silo.position, clickPos, missileSpeed)
	worldData.addEntity(missile)
	siloController.markSiloUsed(silo)
