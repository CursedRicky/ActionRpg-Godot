extends Node2D

var animationPlayer = null
var animationTree = null
var animationState = null

var lootable = false
var enter = false

@onready var player = $"../Player"
@onready var interaction_area = $InteractionArea
@onready var label = $Label

func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationTree.active = true
	animationState = animationTree.get("parameters/playback")
	animationState.travel("Idle")
	label.visible = false

func openChest():
	animationState.travel("Opening")
	
func giveItemsToPlayer() :
	print("Beccate sto trapezio")
	
func _process(delta):
	if !lootable:
		label.visible = enter
	else :
		label.visible = false
	
	if enter:
		if Input.get_action_raw_strength("interact") :
			if !lootable:
				openChest()
				lootable = true

func _on_area_2d_area_entered(area):
	enter = true


func _on_area_2d_area_exited(area):
	enter = false
