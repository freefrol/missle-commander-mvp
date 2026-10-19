class_name CityView3d

extends WorldEntity3D

var cityData: CityData

func _process(delta: float):
	if cityData == null: return
	
	updatePosition(cityData.position)
