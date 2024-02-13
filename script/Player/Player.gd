extends CharacterBody2D
class_name Player

#Variabili globali
const ACCELERATION = 400
const MAXSPEED = 125
const FRICTION = 400
var staminaRegeneration = 5
var speed = MAXSPEED
var DELTA

@onready var swordHitBox = $DestroyOnDeath/HitBoxPivot/SwordHitBox
@onready var animationPlayer = $DestroyOnDeath/AnimationPlayer
@onready var animationTree = $DestroyOnDeath/AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var hurtBox = $DestroyOnDeath/HurtBox
@onready var staminaTimer = $DestroyOnDeath/StaminaTimer
@onready var staminaBar = $DestroyOnDeath/StaBar
@onready var blink = $Blink

enum { #Variabili
	MOVE, #Valore -> 0
	ROLL, #Valore -> 1
	ATTACK, #Valore -> 2
	DEATH #Valore -> 3
}

var state = MOVE
var stats = PlayerStats
var rollVector = Vector2.DOWN

signal healtChange
signal staminaChange

func _ready():
	$DestroyOnDeath/HitBoxPivot/SwordHitBox/CollisionShape2D.disabled = true
	animationTree.active = true
	swordHitBox.knockbackVector = rollVector
	

func _process(delta):
	DELTA = delta
	match state: #simile a switch (state)
		MOVE: 
			move(delta)
		ROLL:
			roll()
		ATTACK:
			attack()
		DEATH:
			death()
			
	if stats.healt <= 0 :
		state = DEATH
	
	if stats.stamina >= 100:
		staminaBar.visible = false
	else : 
		staminaBar.visible = true
		if stats.canRegenerateStamina:
			stats.stamina += staminaRegeneration * delta
			emit_signal("staminaChange")
			
	if stats.stamina < 25 :
		speed = MAXSPEED / 2
	else :
		speed = MAXSPEED

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
		velocity = velocity.move_toward(inputVector * speed, ACCELERATION * delta)
	else :
		animationState.travel("Idle") #Cambia animazione quando stai fermo
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()
	
	if Input.is_action_just_pressed("attack") :
		state = ATTACK
	
	if Input.is_action_just_pressed("roll") and (stats.stamina - 25) > 10:
		state = ROLL

func roll():
	velocity = rollVector * speed * 1.5
	animationState.travel("Roll")
	move_and_slide()
	stats.stamina -= 1
	emit_signal("staminaChange")
	#stats.canRegenerateStamina = false
	staminaTimer.start(3)

func attack():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attackFinished():
	state = MOVE
	velocity = velocity / 2
	
func rollFinished():
	state = MOVE
	
func death():
	$DestroyOnDeath.queue_free()

func _on_hurt_box_area_entered(area): #Il giocatore prende danno
	stats.healt -= area.damage
	hurtBox.startInvincibility(0.5)
	hurtBox.createHitEffect()
	emit_signal("healtChange")
	$HitEffect.play()

func _on_stamina_timer_timeout():
	#stats.canRegenerateStamina = true
	pass


func _on_hurt_box_invincibility_started():
	blink.play("Start")


func _on_hurt_box_invincibility_ended():
	blink.play("Stop")
