extends Node2D

var player

func _change_scene(from, toS, playerIn) -> void:
	player = playerIn
	player.get_parent().remove_child(player)
	SceneTransition._scene_transition(toS)
