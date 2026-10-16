class_name StickControl
extends Control

@export var background: TextureRect
@export var knob: TextureRect

@export var radius: float = 64.0
var direction: Vector2 = Vector2.ZERO
var active: bool = false

var centerOffset: Vector2

func _ready():
	centerOffset = (background.size - knob.size * knob.scale) / 2
	knob.position = centerOffset

func _gui_input(event: InputEvent):
	if event is InputEventScreenTouch:
		accept_event()
		if event.pressed:
			active = true
			updateDirection(event.position)
		else:
			active = false
			direction = Vector2.ZERO
			knob.position = centerOffset
	elif event is InputEventScreenDrag:
		accept_event()
		if active: updateDirection(event.position)

func updateDirection(touchPos: Vector2):
	var center = background.position + background.size / 2
	var offset = touchPos - center
	
	if offset.length() > radius:
		offset = offset.normalized() * radius
	
	direction = offset / radius
	knob.position = centerOffset + offset
