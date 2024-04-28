extends "res://script/Box/hitBox.gd"

var knockbackVector = Vector2.ZERO

func _ready():
	$CollisionShape2D.disabled = true
	$"../PointLight2D".visible = false

func _process(delta):
	if Input.is_action_just_pressed("Area Spell"):
		if PlayerStats.mana >= 20:
			$CollisionShape2D.disabled = false
			$"../PointLight2D".visible = true
			$"../../.."._casting(20)
			$"../AudioStreamPlayer2D".play()
			$"../GPUParticles2D".emitting = true
			await get_tree().create_timer(0.3).timeout
			$"../PointLight2D".visible = false
			$CollisionShape2D.disabled = true
