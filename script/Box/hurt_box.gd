extends Area2D

const HitEffect = preload("res://scenes/Enemy/hit_effect.tscn")

func _on_area_entered(area):
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position - Vector2(0, 8)
