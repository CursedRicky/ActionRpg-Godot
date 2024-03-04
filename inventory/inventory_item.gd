@tool
extends Node2D

@export var item_type = ""
@export var item_name = ""
@export var item_effect = ""
@export var item_Texture : Texture
var scene_path: String = "res://inventory/inventory_item.tscn"

@onready var sprite = $Sprite2D

var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		sprite.texture = item_Texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		sprite.texture = item_Texture
	
	if player_in_range and Input.is_action_just_pressed("pick_items"):
		pickup_item()
	
	$Label.visible = player_in_range

func pickup_item():
	var item = {
		"quantity": 1,
		"type": item_type,
		"name": item_name,
		"effect": item_effect,
		"texture": item_Texture,
		"scene_path": scene_path
	}
	if Global.player_node:
		Global.add_item(item)
		self.queue_free()


func _on_area_2d_body_entered(body):
	if body is Player:
		player_in_range = true


func _on_area_2d_body_exited(body):
	if body is Player:
		player_in_range = false
