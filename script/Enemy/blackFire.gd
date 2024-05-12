extends CharacterBody2D

@export var speed : int = 5
var dir = Vector2.RIGHT

func _ready():
	dir = Vector2.RIGHT.rotated(global_rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = dir * speed
	var collision = move_and_collide(velocity)
	
	if collision:
		queue_free()


func _on_area_2d_area_entered(area):
	queue_free()


func _on_area_2d_area_exited(area):
	queue_free()
