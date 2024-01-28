extends Node2D
@onready var GLOBALS: Node = get_node("/root/Globals")


# Called when the node enters the scene tree for the first time.
func _ready():
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


