extends CharacterBody2D
class_name Bat

const EnemyDeathEffect = preload("res://scenes/Enemy/Death/effectBat.tscn")

var speed = 50
var knockback= Vector2.ZERO
var playerIsInArea = false
var player
const MAXHEALT = 3
var healt = MAXHEALT

@onready var hurtBox = $HurtBox
@onready var hpBar = $HPBar
@onready var damageBar = $HPBar/DamageBar
@onready var damageTimer = $HPBar/Timer
@onready var origin = $Origin

func _ready():
	hpBar.max_value = MAXHEALT
	hpBar.value = healt
	damageBar.max_value = MAXHEALT
	damageBar.value = healt
	hpBar.visible = false
	damageBar.visible = false

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, delta*200)
	velocity = knockback
	if playerIsInArea and !Global.isInvisible:
		position += (player.position - position) / speed
		if position > player.position:
			$Bat.flip_h = true
		else : 
			$Bat.flip_h = false
		
	if healt<=0.5 :
		PlayerStats.exp += 1
		queue_free() 
		var enemyDeathEffect = EnemyDeathEffect.instantiate() 
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position
	move_and_slide()

var inArea = false

func _on_hurt_box_area_entered(area):
	hpBar.visible = true #Rendi la barra degli Hp visibile solo dopo che il mob ha preso danno
	damageBar.visible = true
	var areaD = area.damage
	var damage = 0
	var crit = false
	area.damage *= randf_range(1, 1.2)
	var critN = randi_range(1, 100)
	if !area.dps:
		if Global.isInvisible:
			area.damage *= 1.5
		if area.canCrit and critN < PlayerStats.crit:
			crit = true
			damage = area.damage + area.damage * 0.5 #Danno da critico 150%
			healt-=damage
		else :
			damage = area.damage #Mob prende danno
			healt-=damage
	else:
		inArea = true
		dpsDamage(area)
	if Global.isInvisible:
		Global.isInvisible = false
	DamageNumber.dispay_number(damage, origin.global_position, crit)
	area.damage = areaD
	hpBar.value = healt #Aggiorna barra HP
	damageTimer.start()
	knockback = area.knockbackVector * 125
	hurtBox.createHitEffect()
	$Hit.play()
	$AnimationPlayer.play("Blink")

func dpsDamage(area):
	while inArea:
		healt -= area.damage

func _on_area_2d_body_entered(body):
	if body is Player :
		playerIsInArea = true
		player = body


func _on_area_2d_body_exited(body):
	if body is Player :
		playerIsInArea = false


func _on_timer_timeout():
	damageBar.value = healt


func _on_hurt_box_area_exited(area):
	inArea = false
