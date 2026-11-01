class_name ViewManager
extends Node

@export var worldBounds: WorldBounds
@export var subViewport: SubViewport
@export var worldNode2d: Node2D
@export var worldNode3d: Node3D # <-- Твой контейнер для 3D объектов

# --- 2D Сцены ---
@export var missileViewScene : PackedScene
@export var siloViewScene : PackedScene
@export var playerMissileViewScene : PackedScene
@export var explosionView: PackedScene
@export var cityViewScene: PackedScene

# --- 3D Сцены ---
@export var enemyMissileView3D : PackedScene
@export var playerMissileView3d : PackedScene
@export var explosionView3d : PackedScene
@export var cityView3d : PackedScene
@export var siloView3d : PackedScene # Добавил на будущее

var views: Dictionary = {}
var views3d: Dictionary = {}
# В ViewManager
var radarView: RadarView2D

func setupRadar(p_radarData: RadarData):
	radarView = RadarView2D.new()
	radarView.radarData = p_radarData
	subViewport.add_child(radarView) # Добавляем прямо в SubViewport
	
func onEntityAdded(entity: Entity):
	match entity.getType():
		Entity.Type.MISSILE: onMissileAdded(entity)
		Entity.Type.SILO: onSiloAdded(entity)
		Entity.Type.PLAYER_MISSILE: onPlayerMissileAdded(entity)
		Entity.Type.EXPLOSION: onExplosionAdded(entity)
		Entity.Type.CITY: onCityAdded(entity)
		_: push_warning("Unknown entity type: ", entity.getType())

# --- ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ ---

func create2DView(entity: Entity, scene: PackedScene):
	if scene == null: return
	
	var view = scene.instantiate() as WorldEntity2D
	if view == null:
		push_error("Сцена не наследуется от WorldEntity2D!")
		return
		
	view.entity = entity
	worldNode2d.add_child(view)
	views[entity] = view

func create3DView(entity: Entity, scene: PackedScene):
	if scene == null: return
	
	var view = scene.instantiate() as WorldEntity3D
	if view == null:
		push_error("Сцена не наследуется от WorldEntity3D!")
		return
		
	view.entity = entity
	view.worldBounds = worldBounds
	worldNode3d.add_child(view)
	views3d[entity] = view

# --- МЕТОДЫ ДОБАВЛЕНИЯ ---

func onCityAdded(city: CityData):
	#create2DView(city, cityViewScene)
	create3DView(city, cityView3d)

func onMissileAdded(missile: MissileData):
	#create2DView(missile, missileViewScene)
	create3DView(missile, enemyMissileView3D)

func onSiloAdded(silo: SiloData):
	#create2DView(silo, siloViewScene)
	create3DView(silo, siloView3d)

func onPlayerMissileAdded(missile: PlayerMissileData):
	#create2DView(missile, playerMissileViewScene)
	create3DView(missile, playerMissileView3d)

func onExplosionAdded(explosion: ExplosionData):
	#create2DView(explosion, explosionView)
	create3DView(explosion, explosionView3d)

# --- МЕТОД УДАЛЕНИЯ ---

func onEntityRemoved(entity: Entity):
	var view = views.get(entity)
	if view:
		view.queue_free()
		views.erase(entity)
		
	var view3d = views3d.get(entity)
	if view3d:
		view3d.queue_free()
		views3d.erase(entity)
