class_name PlayerMissileData
extends Entity

var direction: Vector2
var speed: float
var targetPos: Vector2
var radiusExplode: float = 0.2

signal detonated(position: Vector2, owner: Entity.Owner, radius: float, missile:PlayerMissileData)


func _init(p_position, p_target, p_speed):
	super(p_position, Entity.Owner.PLAYER)
	speed = p_speed
	targetPos = p_target
	direction = (p_target - p_position).normalized()

func getType() -> Type:
	return Type.PLAYER_MISSILE

func update(delta):
	if not is_alive: return
	position += direction * speed * delta
	if position.distance_to(targetPos) < 0.01:
		detonate()
		
func detonate():
	is_alive = false
	detonated.emit(position,owner, radiusExplode ,self)
