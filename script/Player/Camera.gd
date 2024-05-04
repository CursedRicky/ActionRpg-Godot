extends Camera2D

var randomStrenght = 5.0
var shakeFade = 5.0

var rng = RandomNumberGenerator.new()
var shakeStr = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.shake:
		applyShake()
	if shakeStr > 0:
		shakeStr = lerpf(shakeStr,0,shakeFade * delta)
		
		offset = randomOffset()	



func applyShake():
	shakeStr = randomStrenght
	

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStr, shakeStr), rng.randf_range(-shakeStr, shakeStr))
