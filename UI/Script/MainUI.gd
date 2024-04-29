extends Control

func _on_gioca_pressed():
	$Sprite2D/CanvasLayer.visible = false
	SceneTransition._scene_transition("res://scenes/Main.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_comandi_pressed():
	pass # Replace with function body.
