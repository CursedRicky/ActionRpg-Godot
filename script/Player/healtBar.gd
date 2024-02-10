extends ProgressBar

@export var player: Player
@onready var timer = $Timer
@onready var dmgBar = $DamageBar
var previusHealt

func _ready():
	player.healtChange.connect(update)
	value = player.stats.healt
	max_value = player.stats.maxHealt
	dmgBar.value = player.stats.healt
	dmgBar.max_value = player.stats.maxHealt
	previusHealt = player.stats.healt
	update()

func update():
	#value = player.stats.healt * 100 / player.stats.maxHealt
	#dmgBar.value = player.stats.healt * 100 / player.stats.maxHealt
	value = player.stats.healt
	if previusHealt > player.stats.healt :
		timer.start()
	else :
		dmgBar.value = player.stats.healt
		
	previusHealt = player.stats.healt
	
func _on_timer_timeout():
	while (dmgBar.value>player.stats.healt):
		dmgBar.value -= 0.5 * player.DELTA
		
