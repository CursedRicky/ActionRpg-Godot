extends CharacterBody2D

var hp = 5
var knockback= Vector2.ZERO

@onready var target = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, delta*200)
	velocity = knockback
	move_and_slide()

func _on_hurt_box_area_entered(area):
	knockback = area.knockbackVector * 125
	
