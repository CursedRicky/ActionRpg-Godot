extends Node2D

var canCast = true
var invisibleControl = false
@onready var invistimer = $InvisTimer
@onready var timer = $"../Barre/hideOnPause/Panel2/Control/Timer"
@onready var CD = $"../Barre/hideOnPause/Panel2/Control/CD"
@onready var time = $"../Barre/hideOnPause/Panel2/Control/Time"
@onready var insibileAnim = $Invisible

# Called when the node enters the scene tree for the first time.
func _ready():
	CD.max_value = timer.wait_time
	time.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time.text = "%3.1f" % timer.time_left
	CD.value = timer.time_left
	if canCast:
		if Input.is_action_just_pressed("2"):
			if PlayerStats.mana >= 50:
				timer.start()
				time.visible = true
				$"../.."._casting(50)
				canCast = false
				invistimer.start()
				Global.isInvisible = true
				invisibleControl = true
	if Global.isInvisible and invisibleControl:
		insibileAnim.play("invisible")
	elif !Global.isInvisible and invisibleControl:
		insibileAnim.play("noInvis")
		invisibleControl = false
	


func _on_invis_timer_timeout():
	Global.isInvisible = false

func _on_timer_timeout():
	time.visible = false
	canCast = true
