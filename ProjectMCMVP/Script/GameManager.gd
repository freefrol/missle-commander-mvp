extends Node

@export var viewManager : ViewManager
@export var shootController: ShootController
@export var restartButton: Button
@export var canvas: CanvasLayer

var world_data: WorldData
var enemy_spawner: EnemySpawner
var siloController: SiloController
var explosionController: ExplosionController
var cityController: CityController 

func _ready():
	world_data = WorldData.new()
	world_data.entityAdded.connect(viewManager.onEntityAdded)
	world_data.entityRemoved.connect(viewManager.onEntityRemoved)
	
	cityController = CityController.new(world_data)
	explosionController = ExplosionController.new(world_data)
	enemy_spawner = EnemySpawner.new(world_data)
	siloController = SiloController.new(world_data)
	shootController.siloController = siloController
	shootController.worldData = world_data
	
	
	cityController.allCitiesDestroyed.connect(allCitiesDestroed)
	restartButton.pressed.connect(onRestartButtonPressed)
	
func allCitiesDestroed():
	shootController.isGameStop = true
	enemy_spawner.isGameStop = true
	canvas.visible = true
	
func onRestartButtonPressed():
	get_tree().reload_current_scene()
	
	
func _process(delta):
	world_data.update(delta)
	enemy_spawner.update(delta)
	siloController.update(delta)
	explosionController.update(delta)
