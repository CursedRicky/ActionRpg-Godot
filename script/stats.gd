extends Node

@export var maxHealt = 1
@onready var healt = maxHealt

func _process(delta):
	if healt <= 0:
		emit_signal("noHealt")

signal noHealt
