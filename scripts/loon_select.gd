extends HBoxContainer

var selected: bool = false
@export var ship_sprite: Sprite2D

func _on_loon_button_pressed():
	selected = !selected
	if selected:
		ship_sprite.frame += 1
	else:
		ship_sprite.frame -= 1
