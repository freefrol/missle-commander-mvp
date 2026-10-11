class_name SiloData
extends Entity

var isReady: bool = true
var isDestroyed : bool = false

var reloadTime: float = 3
var repairTime: float = 15

var reloadCustomTimer: CustomTimer
var repairCustomTimer: CustomTimer

signal ready(siloData: SiloData)
signal destroyed(siloData: SiloData)

func _init(p_position: Vector2) -> void:
	super(p_position, Entity.Owner.PLAYER)
	
	reloadCustomTimer = CustomTimer.new(reloadTime)
	repairCustomTimer = CustomTimer.new(repairTime)
	
	reloadCustomTimer.ready.connect(reloadReady)
	repairCustomTimer.ready.connect(repairReady)
	

func reloadReady():
	isReady = true
	ready.emit(self)
	
func repairReady():
	isDestroyed = false
	repairCustomTimer.restart()
	
func getType() -> Type:
	return Type.SILO
	
func update(delta: float):
	if isDestroyed:
		repairCustomTimer.update(delta)
	elif not isReady:
		reloadCustomTimer.update(delta)

func restartSilos():
	isReady = false
	reloadCustomTimer.restart()
	
func detonate():
	isDestroyed = true
	restartSilos()
	repairCustomTimer.restart()
	destroyed.emit(self)
	
func getReloadProgress() -> float:
	return reloadCustomTimer.currentTime / reloadCustomTimer.maxTime
	
