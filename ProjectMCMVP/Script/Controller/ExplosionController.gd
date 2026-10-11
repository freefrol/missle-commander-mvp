class_name ExplosionController
extends RefCounted

var worldData: WorldData
var explosions: Array[ExplosionData] = []

func _init(p_worldData: WorldData):
	worldData = p_worldData
	worldData.entityAdded.connect(onEntityAdded)

func onEntityAdded(entity: Entity):
	if entity.has_signal("detonated"):
		entity.detonated.connect(onDetonated)

func onDetonated(position: Vector2, owner: Entity.Owner, radius: float, entity: Entity):
	var explosionData = ExplosionData.new(position, owner, radius)
	explosions.append(explosionData)
	worldData.addEntity(explosionData)
	

func update(delta: float):
	for explosion in explosions:
		checkHits(explosion)
	explosions = explosions.filter(func(e): return e.is_alive)

func checkHits(explosion: ExplosionData):
	for entity in worldData.getEntities():
		if not entity.is_alive: continue
		if entity == explosion: continue
		
		if explosion.owner == Entity.Owner.ENEMY and entity.getType() == Entity.Type.PLAYER_MISSILE: continue
		if explosion.owner == Entity.Owner.PLAYER and entity.owner == Entity.Owner.PLAYER: continue
		if not entity.has_method("detonate"): continue
		if entity.position.distance_to(explosion.position) <= explosion.currentRadius:
			entity.detonate()
