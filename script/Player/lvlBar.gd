extends ProgressBar

@export var player: Player

func _ready():
	player.lvlUp.connect(update)
	value = PlayerStats.exp
	max_value = PlayerStats.maxExp
	update()

func update():
	$Label.text = str(PlayerStats.lvl)
	max_value = PlayerStats.maxExp
		
	
func _process(delta):
	value = PlayerStats.exp
