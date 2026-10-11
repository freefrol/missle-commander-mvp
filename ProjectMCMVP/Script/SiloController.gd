class_name SiloController
extends RefCounted

var world_data: WorldData
var siloReadyArray : Array[SiloData]

func _init(p_world_data: WorldData):
	world_data = p_world_data
	
	var siloPositionArray = [
		Vector2(0.1, 1),
		Vector2(0.5, 1),
		Vector2(0.9, 1)
	]
	
	var siloDataArray = [
		SiloData.new(siloPositionArray[0]),
		SiloData.new(siloPositionArray[1]),
		SiloData.new(siloPositionArray[2])
	]
	
	for siloData :SiloData in siloDataArray:
		world_data.addEntity(siloData)
		
		if siloData.isReady:
			siloReadyArray.append(siloData)
		siloData.ready.connect(siloReady)
		siloData.destroyed.connect(siloDestroed)
		
func siloReady(siloData: SiloData):
	siloReadyArray.append(siloData)
	
func siloDestroed(siloData: SiloData):
	siloReadyArray.erase(siloData)
		
func update(delta: float):
	pass

func getReadySilos() -> Array[SiloData]:
	return siloReadyArray

func getNearestReadySilo(targetPos: Vector2) -> SiloData:
	if siloReadyArray.is_empty():
		return null
	
	var nearest: SiloData = siloReadyArray[0]
	var minDist := nearest.position.distance_squared_to(targetPos)
	
	for silo in siloReadyArray:
		var dist = silo.position.distance_squared_to(targetPos)
		if dist < minDist:
			minDist = dist
			nearest = silo
	
	return nearest

func markSiloUsed(silo: SiloData):
	siloReadyArray.erase(silo)
	silo.restartSilos()
	
