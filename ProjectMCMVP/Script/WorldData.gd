class_name WorldData
extends RefCounted

var entitys: Array[Entity] = []

signal entityAdded(entity: Entity)
signal entityRemoved(entity: Entity)

func addEntity(entity: Entity):
	entitys.append(entity)
	entityAdded.emit(entity)
	
func getEntities() -> Array[Entity]:
	return entitys.duplicate()
	
func update(delta):
	for entity in entitys:
		entity.update(delta)
		if not entity.is_alive:
			entityRemoved.emit(entity)
		
	entitys = entitys.filter(func(m): return m.is_alive)
