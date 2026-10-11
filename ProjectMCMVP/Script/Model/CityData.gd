class_name CityData

extends Entity

signal destroyed(city: CityData)

func _init(p_position: Vector2):
	super(p_position, Owner.PLAYER)

func update(delta: float):
	pass
	
func getType() -> Type:
	return Type.CITY
	
func detonate():
	is_alive = false
	destroyed.emit(self)
