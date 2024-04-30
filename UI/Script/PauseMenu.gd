extends Control

@export var player : Player
@export var manaBar : ProgressBar
@export var healtBar: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("RESET")

func testEsc():
	if Input.is_action_just_pressed("Esci") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Esci") and get_tree().paused:
		resume()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.canPause:
		testEsc()


func _on_riprendi_pressed():
	resume()



func _on_esci_pressed():
	SceneTransition._scene_transition("res://UI/MainUI.tscn")
	resume()


func _on_comandi_pressed():
	pass # Replace with function body.


func _on_salva_pressed():
	pass # Replace with function body.


func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	player.canMove = false
	healtBar.visible = false
	manaBar.visible = false
	
	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	player.canMove = true
	await get_tree().create_timer(.3).timeout
	healtBar.visible = true
	manaBar.visible = true
	$AnimationPlayer.play("RESET")
