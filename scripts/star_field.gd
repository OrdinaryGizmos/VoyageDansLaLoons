extends CanvasLayer

@onready var PLAYER: Node2D = get_parent().find_child("Player")
@onready var MATERIAL: ShaderMaterial = find_child("StarField").material

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	MATERIAL.set_shader_parameter("PlayerPosition", PLAYER.global_position / 5000)
