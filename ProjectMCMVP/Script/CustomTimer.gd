class_name CustomTimer
extends RefCounted

var maxTime
var currentTime = 0
var isReady = false

signal ready()

func _init(_maxTime : float = 1) -> void:
	maxTime = _maxTime
	
func update(delta: float) -> void:
	if isReady:
		return
		
	currentTime += delta
	
	if currentTime >= maxTime:
		isReady = true
		currentTime = 0
		ready.emit()
		
func restart():
		isReady = false
		currentTime = 0
