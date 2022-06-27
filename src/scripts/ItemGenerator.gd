extends Node2D

export(PackedScene) var _meteorite = null
var _seconds: float = 0.0
var _randGenerate = RandomNumberGenerator.new()
var _timerItens = null

func genMeteorite():
	if _meteorite != null:
		var item = _meteorite.instance()
		item.position.x = _randGenerate.randi_range(30,900)
		item.position.y = -100
		add_child(item)
		
func spawnItem():
	print("Second!")

func _ready():
	_randGenerate.randomize()
	_timerItens = Timer.new()
	add_child(_timerItens)

	_timerItens.connect("timeout", self, "spawnItem")
	_timerItens.set_wait_time(1.0)
	_timerItens.set_one_shot(false) # Make sure it loops
	_timerItens.start()
	pass
	
func _physics_process(delta):
	_seconds += delta
	pass
