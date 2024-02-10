extends CharacterBody2D
class_name Slime

const EnemyDeathEffect = preload("res://scenes/Enemy/Death/effect.tscn")

var speed = 40
var knockback= Vector2.ZERO
var playerIsInArea = false
var player
var DELTA

const MAXHEALT = 5
var healt = MAXHEALT

@onready var hurtBox = $HurtBox
@onready var hpBar = $HPBar
@onready var damageBar = $HPBar/DamageBar
@onready var damageTimer = $HPBar/Timer

func _ready():
	hpBar.max_value = MAXHEALT
	hpBar.value = healt
	damageBar.max_value = MAXHEALT
	damageBar.value = healt
	hpBar.visible = false
	damageBar.visible = false

func _physics_process(delta):
	DELTA = delta
	knockback = knockback.move_toward(Vector2.ZERO, delta*200)
	velocity = knockback
	if playerIsInArea :
		position += (player.position - position) / speed
		
	if healt<=0 :
		queue_free() #Elimina nodo
		var enemyDeathEffect = EnemyDeathEffect.instantiate() #Inizia animazione morte
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position #Posizione l'effetto nella stessa posizione dello slime
	move_and_slide()

func _on_hurt_box_area_entered(area): #Il mob è colpito dal giocatore
	hpBar.visible = true #Rendi la barra degli Hp visibile solo dopo che il mob ha preso danno
	damageBar.visible = true
	healt -= area.damage #Mob prende danno
	hpBar.value = healt #Aggiorna barra HP
	damageTimer.start()
	knockback = area.knockbackVector * 200 #Prendi knockback
	hurtBox.createHitEffect() #Avvia animazione colpo


func _on_area_2d_body_entered(body):
	if body is Player :
		playerIsInArea = true
		player = body


func _on_area_2d_body_exited(body):
	if body is Player :
		velocity = velocity.move_toward(Vector2.ZERO, 400*DELTA)
		playerIsInArea = false


func _on_timer_timeout():
	damageBar.value = healt
