extends Node2D

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

var lootable = false
var enter = false

@onready var player = $"../Player"
@onready var interaction_area = $InteractionArea
@onready var label = $Label

func _ready(): 
	animationTree.active = true
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
