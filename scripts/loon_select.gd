extends Node2D

@export var ship_sprite: Sprite2D
@onready var LAUNCHBUTTON = get_parent().find_child("LaunchButton")
@onready var GLOBALS: Node = get_node("/root/Globals")

func _on_loon_button_pressed(toggle):
	if toggle:
		GLOBALS.LOONCOUNT += 1
	else:
		GLOBALS.LOONCOUNT -= 1

	if GLOBALS.LOONCOUNT > 0:
		LAUNCHBUTTON.show()
	else:
		LAUNCHBUTTON.hide()

	_hide_all()
	if GLOBALS.LOONCOUNT == 0:
		$ShipEmpty.show()
	if GLOBALS.LOONCOUNT == 1:
		$ShipCrew1.show()
	if GLOBALS.LOONCOUNT == 2:
		$ShipCrew2.show()
	if GLOBALS.LOONCOUNT == 3:
		$ShipCrew3.show()

func _hide_all():
	for child in get_children():
		child.hide()
