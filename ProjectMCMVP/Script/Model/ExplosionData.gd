class_name ExplosionData
extends RadarVisibleEntity

var currentRadius: float
var maxRadius: float
var lifetime: float = 1.0
var elapsed: float = 0.0

func _init(p_position: Vector2, p_owner: Owner, p_radius):
	super(p_position, p_owner)
	maxRadius = p_radius
		# Настройки для радара:
	blip_color = Color.WHITE     # Белая вспышка
	requires_sweep = false       # Появляется сразу!
	fade_time = 0.5              # Исчезает за 0.5 секунды
	
func getType() -> Type:
	return Entity.Type.EXPLOSION

func update(delta: float):
	elapsed += delta
	if elapsed >= lifetime:
		is_alive = false
		return
	var t = elapsed / lifetime
	currentRadius = maxRadius * sin(t * PI)
