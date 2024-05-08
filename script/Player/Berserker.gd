extends Node2D

var canCast = true
@onready var timer = $"../Barre/Panel4/Control/Timer"
@onready var CD = $"../Barre/Panel4/Control/CD"
@onready var time = $"../Barre/Panel4/Control/Time"

var playerCrit = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	CD.max_value = timer.wait_time
	time.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time.text = "%3.1f" % timer.time_left
	CD.value = timer.time_left
	if canCast:
		if Input.is_action_just_pressed("4"):
			if PlayerStats.mana >= 40 and PlayerStats.healt - 20 > 1:
				timer.start()
				time.visible = true
				$"../.."._casting(40)
				canCast = false
				$AnimationPlayer.play("fuoco")
				$Berserk.start()
				playerCrit = PlayerStats.crit
				PlayerStats.crit = 75
				PlayerStats.healt -= 20
				$"../..".healing()
				

func _on_timer_timeout():
	time.visible = false
	canCast = true
	
func _on_spada_di_fuoco_timeout():
	$AnimationPlayer.play("noFuoco")
	PlayerStats.crit = playerCrit
	
