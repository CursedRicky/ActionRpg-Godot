extends ProgressBar

@export var player: Player
@onready var timer = $Timer
@onready var dmgBar = $DamageBar
var previusMana

func _ready():
	player.manaChange.connect(update)
	value = PlayerStats.mana
	max_value = PlayerStats.maxMana
	dmgBar.value = PlayerStats.mana
	dmgBar.max_value = PlayerStats.maxMana
	previusMana = PlayerStats.mana
	update()

func update():
	value = PlayerStats.mana
	if previusMana > PlayerStats.mana :
		timer.start()
	else :
		dmgBar.value = PlayerStats.mana
		
	previusMana = PlayerStats.mana
	
func _on_timer_timeout():
	while (dmgBar.value>PlayerStats.mana):
		dmgBar.value -= 0.5 * player.DELTA
		
