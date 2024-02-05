extends CharacterBody2D

var knockback= Vector2.ZERO

@onready var target = $"../Player"
@onready var stats = $Stats

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, delta*200)
	velocity = knockback
	move_and_slide()

func _on_hurt_box_area_entered(area):
	stats.healt -= area.damage
	knockback = area.knockbackVector * 125

func _on_stats_no_healt():
	queue_free()
