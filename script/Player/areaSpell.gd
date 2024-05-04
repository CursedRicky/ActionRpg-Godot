extends "res://script/Box/hitBox.gd"

var knockbackVector = Vector2.ZERO
@onready var lightP = $"../GPUParticles2D/PointLight2D"

var canCast = true

func _ready():
	$CollisionShape2D.disabled = true
	lightP.visible = false

func _process(delta):
	if canCast:
		if Input.is_action_just_pressed("Area Spell"):
			if PlayerStats.mana >= 20:
				canCast = false
				Global.shake = true
				$CollisionShape2D.disabled = false
				lightP.visible = true
				$"../../.."._casting(20)
				$"../AudioStreamPlayer2D".play()
				$"../GPUParticles2D".emitting = true
				await get_tree().create_timer(0.3).timeout
				Global.shake = false
				lightP.visible = false
				$CollisionShape2D.disabled = true
				await get_tree().create_timer(2.5).timeout
				canCast = true
