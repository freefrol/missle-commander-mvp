class_name ViewManager
extends Node

@export var subViewport: SubViewport
@export var worldNode2d: Node2D
@export var missileViewScene : PackedScene
@export var siloViewScene : PackedScene
@export var playerMissileViewScene : PackedScene
@export var explosionView: PackedScene
@export var cityViewScene: PackedScene
@export var enemyMissileView3D : PackedScene
@export var playerMissileView3d : PackedScene
@export var explosionView3d : PackedScene

var views: Dictionary = {}
var views3d: Dictionary = {}
	

func onEntityAdded(entity: Entity):
	match entity.getType():
		Entity.Type.MISSILE: onMissileAdded(entity)
		Entity.Type.SILO: onSiloAdded(entity)
		Entity.Type.PLAYER_MISSILE: onPlayerMissileAdded(entity)
		Entity.Type.EXPLOSION: onExplosionAdded(entity)
		Entity.Type.CITY: onCityAdded(entity)
		_: push_warning("Unknown entity type: ", entity.getType())
	


func onCityAdded(city: CityData):
	var view: CityView = cityViewScene.instantiate()
	view.cityData = city
	worldNode2d.add_child(view)
	views[city] = view
	
func onMissileAdded(missile: MissileData):
	var view: MissileView = missileViewScene.instantiate()
	view.missileData = missile
	worldNode2d.add_child(view)
	views[missile] = view
	
	var view3d : EnemyMissileView3D = enemyMissileView3D.instantiate()
	view3d.missileData = missile
	add_child(view3d)
	views3d[missile] = view3d
	
func onSiloAdded(silo: SiloData):
	var view: SiloView = siloViewScene.instantiate()
	view.siloData = silo
	worldNode2d.add_child(view)
	views[silo] = view
	
func onPlayerMissileAdded(missile: PlayerMissileData):
	var view: PlayerMissileView = playerMissileViewScene.instantiate()
	view.playerMissileData = missile
	worldNode2d.add_child(view)
	views[missile] = view
	
	var view3d : PlayerMissileView3d = playerMissileView3d.instantiate()
	view3d.missileData = missile
	add_child(view3d)
	views3d[missile] = view3d

func onEntityRemoved(entity: Entity):
	var view = views.get(entity)
	if view:
		view.queue_free()
		views.erase(entity)
		
	var view3d = views3d.get(entity)
	if view3d:
		view3d.queue_free()
		views3d.erase(entity)
		
func onExplosionAdded(explosion:ExplosionData):
	var view: ExplosionView = explosionView.instantiate()
	view.explosionData = explosion
	worldNode2d.add_child(view)
	views[explosion] = view

	var view3d : ExplosionView3D = explosionView3d.instantiate()
	view3d.explosionData = explosion
	add_child(view3d)
	views3d[explosion] = view3d
