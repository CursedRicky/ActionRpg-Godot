extends Node2D

var animationPlayer = null
var animationTree = null
var animationState = null
@onready var interaction_area = $InteractionArea

func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback")
	animationState.travel("Idle")

func _on_interact():
	animationState.travel("Opening")
	
func _process(delta):
	if Global.openChest : 
		_on_interact()
		Global.openChest = false
		interaction_area.free()
