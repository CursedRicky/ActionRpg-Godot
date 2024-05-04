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
	if playerIsInArea :
		position += (player.position - position) / speed
		
	if healt<=0 :
		queue_free() 
		var enemyDeathEffect = EnemyDeathEffect.instantiate() 
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position
	move_and_slide()

var inArea = false

func _on_hurt_box_area_entered(area):
	hpBar.visible = true
	damageBar.visible = true
	var critN = randi_range(1, 100)
	if !area.dps:
		if area.canCrit and critN < PlayerStats.crit:
			healt -= area.damage + area.damage * 0.5 #Danno da critico 150%
		else :
			healt -= area.damage #Mob prende danno
	else:
		inArea = true
		dpsDamage(area)
	hpBar.value = healt
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
