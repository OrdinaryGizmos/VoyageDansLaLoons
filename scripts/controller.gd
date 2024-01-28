extends Node

# make this a child of the thing you want to control!
@onready var parent:Node2D = get_parent()

# func _physics_process(_delta: float) -> void:
# 	parent.thrust_input = Input.get_axis("back", "forward")
# 	parent.turn_input = Input.get_axis("left", "right")
