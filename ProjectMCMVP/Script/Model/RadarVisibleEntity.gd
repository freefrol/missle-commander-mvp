@abstract
class_name RadarVisibleEntity
extends Entity

var is_stealth: bool = false
var blip_color: Color = Color.RED

# Новые свойства:
var requires_sweep: bool = true  # Нужно ли ждать луч (для ракет - да)
var fade_time: float = 3.0       # Сколько времени висит метка
