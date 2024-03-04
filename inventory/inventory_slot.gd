extends Control

@onready var icon = $InnerBorder/Sprite2D
@onready var quantity_label = $InnerBorder/Label
@onready var details_panel = $Detail
@onready var item_name = $Detail/Name
@onready var item_type = $Detail/Type
@onready var item_effect = $Detail/Effect
@onready var usage_panel = $Usage

var item = null

func _on_item_button_pressed():
	if item != null:
		usage_panel.visible = true
		details_panel.visible = false


func _on_item_button_mouse_entered():
	if item != null:
		details_panel.visible = !details_panel.visible


func _on_item_button_mouse_exited():
	if item != null:
		details_panel.visible = false

func set_empty():
	icon.texture = null
	quantity_label.text = ""
	
func set_item(new_item):
	item = new_item
	icon.texture = new_item["texture"]
	quantity_label.text = str(item["quantity"])
	item_name = str(item["name"])
	item_type = str(item["type"])
	if item["effect"] != "":
		item_effect.text = str(" +", item["effect"])
	else :
		item_effect.text = ""
