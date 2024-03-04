extends Node

var weather = "none"
var player_node: Node = null
@onready var inventory_slot_scene = preload("res://inventory/inventory_slots_2.tscn")

var inventory = []

signal inventory_updated

func _ready():
	inventory.resize(27)

func set_player_reference(player):
	player_node = player
	
func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["effect"] == item["effect"]:
			inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit()
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_updated.emit()
			return true
		return false
			

func remove_item():
	inventory_updated.emit()
	
func increse_inventory_size():
	inventory_updated.emit()
