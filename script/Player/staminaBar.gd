extends ProgressBar

@export var player = Player

func _ready():
	player.staminaChange.connect(update)
	update()

func update():
	value = player.stats.stamina * 100 / player.stats.maxStamina
