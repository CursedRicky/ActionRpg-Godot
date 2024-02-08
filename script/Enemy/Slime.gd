extends CharacterBody2D

const EnemyDeathEffect = preload("res://scenes/Enemy/Death/effect.tscn")

var speed = 40
var knockback= Vector2.ZERO
var playerIsInArea = false
var player
var healt = 5
var DELTA

@onready var detArea = $DetectionArea/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	DELTA = delta
	knockback = knockback.move_toward(Vector2.ZERO, delta*200)
	velocity = knockback
	if playerIsInArea :
		position += (player.position - position) / speed
		
	if healt<=0 :
		queue_free()
		var enemyDeathEffect = EnemyDeathEffect.instantiate()
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position
	move_and_slide()

func _on_hurt_box_area_entered(area):
	healt -= area.damage
	knockback = area.knockbackVector * 200


func _on_area_2d_body_entered(body):
	if body is Player :
		playerIsInArea = true
		player = body


func _on_area_2d_body_exited(body):
	if body is Player :
		velocity = velocity.move_toward(Vector2.ZERO, 400*DELTA)
		playerIsInArea = false
