extends Node

var canRain = true
var canPause = true
var weather = "none"
var player_node: Player = null
var shake = false
var death = false
var speedMult = 1

var healtPotion = 0

var isInvisible = false

var isInventoryOpen = true

var playerEsce = false
var coord

func set_player_reference(player):
	player_node = player

var itemsLoad = [
	"res://Inventory/Items/healingPotion.tres",
	"res://Inventory/Items/manaPotion.tres"
]
