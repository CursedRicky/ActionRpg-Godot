extends Control

func _on_gioca_pressed():
	SceneTransition._scene_transition("res://scenes/Main.tscn")
	$AnimationPlayer.play("pulsanti")

func _on_exit_pressed():
	get_tree().quit()


func _on_comandi_pressed():
	pass # Replace with function body.
