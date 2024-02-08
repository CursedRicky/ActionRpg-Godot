extends CharacterBody2D
class_name Player

#Variabili globali
const ACCELERATION = 400
const MAXSPEED = 125
const FRICTION = 400 

@onready var swordHitBox = $HitBoxPivot/SwordHitBox
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var interactLabel = $Interaction/InteractLabel
@onready var animationState = animationTree.get("parameters/playback")
@onready var all_interactions = []

enum { #Variabili
	MOVE, #Valore -> 0
	ROLL, #Valore -> 1
	ATTACK #Valore -> 2
}

var state = MOVE
var rollVector = Vector2.DOWN

func _ready():
	animationTree.active = true
	swordHitBox.knockbackVector = rollVector
	

func _process(delta):
	match state: #simile a switch (state)
		MOVE: 
			move(delta)
		ROLL:
			roll(delta)
		ATTACK:
			attack(delta)
	
	#if Input.get_action_strength("space_bar") or Input.get_action_strength("left_click"):
		#print("Ciao")

func move(delta) :
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized() #Vettore normalizzato così che il pg non sia più veloce in diagonale
	
	if inputVector != Vector2.ZERO:
		rollVector = inputVector
		swordHitBox.knockbackVector = inputVector
		animationTree.set("parameters/Idle/blend_position", inputVector)
		animationTree.set("parameters/Run/blend_position", inputVector)
		animationTree.set("parameters/Attack/blend_position", inputVector)
		animationTree.set("parameters/Roll/blend_position", inputVector)
		animationState.travel("Run") #Cambia animazione quando cammini
		velocity = velocity.move_toward(inputVector * MAXSPEED, ACCELERATION * delta)
	else :
		animationState.travel("Idle") #Cambia animazione quando stai fermo
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()
	
	if Input.is_action_just_pressed("attack") :
		state = ATTACK
	
	if Input.is_action_just_pressed("roll") :
		state = ROLL

func roll(delta):
	velocity = rollVector * MAXSPEED * 1.25
	animationState.travel("Roll")
	move_and_slide()

func attack(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attackFinished():
	state = MOVE
	velocity = velocity / 2
	
func rollFinished():
	state = MOVE
	
func player():
	pass
