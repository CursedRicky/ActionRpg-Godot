extends CharacterBody2D

#Variabili globali
const ACCELERATION = 400
const MAXSPEED = 125
const FRICTION = 400 

var animationPlayer = null
var animationTree = null
var animationState = null

enum { #Variabili
	MOVE, #Valore -> 0
	ROLE, #Valore -> 1
	ATTACK #Valore -> 2
}

var state = MOVE

func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback")

func _process(delta):
	match state: #simile a switch (state)
		MOVE: 
			move(delta)
		ROLE:
			pass
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
		animationTree.set("parameters/Idle/blend_position", inputVector)
		animationTree.set("parameters/Run/blend_position", inputVector)
		animationTree.set("parameters/Attack/blend_position", inputVector)
		animationState.travel("Run") #Cambia animazione quando cammini
		velocity = velocity.move_toward(inputVector * MAXSPEED, ACCELERATION * delta)
	else :
		animationState.travel("Idle") #Cambia animazione quando stai fermo
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()
	
	if Input.is_action_just_pressed("attack") :
		state = ATTACK

func attack(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attackFinished():
	state = MOVE
