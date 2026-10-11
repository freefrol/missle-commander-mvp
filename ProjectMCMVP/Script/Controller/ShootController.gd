class_name ShootController
extends Node2D

@export var missileSpeed:  float = 0.1
var siloController: SiloController
var worldData: WorldData
var isGameStop : bool = false

# ShotController._input
func _input(event):
	if isGameStop : return
	
	if not event is InputEventMouseButton or not event.pressed:
		return
		
	var clickPos = get_global_mouse_position() / get_viewport_rect().size
	var silo = siloController.getNearestReadySilo(clickPos)
	if silo == null: return
	var missile = PlayerMissileData.new(silo.position, clickPos, missileSpeed)
	worldData.addEntity(missile)
	siloController.markSiloUsed(silo)
