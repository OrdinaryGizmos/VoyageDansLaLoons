extends Node

@onready var GLOBALS: Node = get_node("/root/Globals")

# Called when the node enters the scene tree for the first time.
func _ready():
	var globals = get_tree().call_deferred("get_node","/root/Globals")
	globals.LOONVIEW = self

