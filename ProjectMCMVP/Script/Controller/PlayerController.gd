class_name PlayerController

extends CharacterBody3D

@export var moveJoystick: StickControl
@export var lookJoystick: StickControl
@export var cameraPivot: Node3D
@export var moveSpeed : float = 0.1
@export var turnSpeed : float = 0.1

func move(inputDir: Vector2):
	# inputDir - это Vector2 от джойстика (x - влево/вправо, y - вперед/назад)
	if inputDir.length() > 0:
		# 1. Создаем 3D вектор на основе ввода (Y джойстика соответствует Z в 3D, но в Godot "вперед" это -Z)
		var direction = Vector3(inputDir.x, 0, inputDir.y)
		
		# 2. Поворачиваем вектор вместе с игроком (чтобы "вперед" всегда было туда, куда смотрит камера)
		# transform.basis делает все вычисления за нас
		var globalDir = (transform.basis * direction).normalized() 
		
		# 3. Применяем скорость
		velocity.x = globalDir.x * moveSpeed
		velocity.z = globalDir.z * moveSpeed
	else:
		# Если джойстик отпущен — останавливаемся
		velocity.x = 0
		velocity.z = 0
func _physics_process(delta: float) -> void:
	# 1. Движение (с учетом поворота игрока)
	move(moveJoystick.direction)
	move_and_slide()
	
	# 2. Поворот (yaw для игрока, pitch для камеры)
	rotation.y -= turnSpeed * lookJoystick.direction.x
	cameraPivot.rotation.x -= turnSpeed * lookJoystick.direction.y
	cameraPivot.rotation.x = clamp(cameraPivot.rotation.x, -1.4, 1.4)
