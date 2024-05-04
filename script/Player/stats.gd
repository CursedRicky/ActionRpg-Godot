extends Node

@export var maxHealt = 1
@export var maxMana = 100
@onready var mana = maxMana
@onready var healt = maxHealt

@export var crit = 15
@export var manaRegen = 1

var gold = 0

var canRegenerateStamina = true
var maxStamina = 100
@onready var stamina = maxStamina
