class_name ExplosionView2D
extends WorldEntity2D

func _process(delta: float):
	super._process(delta) # Вызываем базу для обновления позиции
	queue_redraw()        # Просим Godot перерисовать

func _draw():
	if entity is ExplosionData:
		var explosion = entity as ExplosionData
		# entity.position уже учтен в position узла (благодаря base классу),
		# поэтому рисуем круг прямо по центру узла (0,0)
		var screenRadius = explosion.currentRadius * getWorldSide()
		
		draw_circle(Vector2.ZERO, screenRadius, Color(1, 0.5, 0, 0.6))
