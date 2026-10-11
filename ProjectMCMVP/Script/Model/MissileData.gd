class_name MissileData
extends Entity

var speed: float
var direction: Vector2
var explodY: float
var radiusExplode: float = 0.2

signal detonated(position: Vector2, owner: Entity.Owner, radius: float, missile:MissileData)

func _init(p_position: Vector2, p_direction: Vector2, p_speed: float, p_explodeY: float):
	super(p_position, Entity.Owner.ENEMY)
	speed = p_speed
	direction = p_direction
	explodY = p_explodeY
	
func update(delta: float):
	if not is_alive:
		return
		
	position += direction * speed * delta
	
	if position.y >= explodY :
		detonate()
		
func detonate():
	is_alive = false
	detonated.emit(position,owner, radiusExplode ,self)
	
func getType() -> Type:
	return Type.MISSILE
	
