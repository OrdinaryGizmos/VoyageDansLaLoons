extends TextureButton

@export var LoonName: StringName
@onready var GLOBALS: Node = get_node("/root/Globals")

func _toggled(toggled_on):
	GLOBALS.LOONS.erase(LoonName)
	if toggled_on:
		GLOBALS.LOONS.push_front(LoonName)

