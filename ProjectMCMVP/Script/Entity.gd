@abstract
class_name Entity

extends RefCounted

enum Type { MISSILE, SILO, CITY, PLAYER_MISSILE, EXPLOSION }
enum Owner { PLAYER, ENEMY }
var owner: Owner
var is_alive: bool = true
var position: Vector2

func _init(p_position: Vector2, p_owner: Owner):
	position = p_position
	owner = p_owner

@abstract
func update(delta: float)

@abstract
func getType() -> Type

	
