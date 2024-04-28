extends ProgressBar

@export var player: Player
@onready var timer = $Timer
@onready var dmgBar = $DamageBar
var previusHealt

func _ready():
	player.healtChange.connect(update)
	value = PlayerStats.healt
	max_value = PlayerStats.maxHealt
	dmgBar.value = PlayerStats.healt
	dmgBar.max_value = PlayerStats.maxHealt
	previusHealt = PlayerStats.healt
	update()

func update():
	#value = player.stats.healt * 100 / player.stats.maxHealt
	#dmgBar.value = player.stats.healt * 100 / player.stats.maxHealt
	value = PlayerStats.healt
	if previusHealt > PlayerStats.healt :
		timer.start()
	else :
		dmgBar.value = PlayerStats.healt
		
	previusHealt = PlayerStats.healt
	
func _on_timer_timeout():
	while (dmgBar.value>PlayerStats.healt):
		dmgBar.value -= 0.5 * player.DELTA
		
