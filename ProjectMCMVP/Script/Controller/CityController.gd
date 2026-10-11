class_name CityController

extends RefCounted

var worldData: WorldData
var cityArray: Array[CityData]

signal allCitiesDestroyed

func _init(world_data:WorldData) -> void:
	worldData = world_data
	
	cityArray.append(CityData.new(Vector2(0.2,1)))
	cityArray.append(CityData.new(Vector2(0.3,1)))
	cityArray.append(CityData.new(Vector2(0.4,1)))
	cityArray.append(CityData.new(Vector2(0.6,1)))
	cityArray.append(CityData.new(Vector2(0.7,1)))
	cityArray.append(CityData.new(Vector2(0.8,1)))
	
	for city: CityData in cityArray:
		worldData.addEntity(city)
		city.destroyed.connect(cityDestroyed)
		
func cityDestroyed(city:CityData):
	cityArray.erase(city)
	if cityArray.size() == 0:
		allCitiesDestroyed.emit()
	
