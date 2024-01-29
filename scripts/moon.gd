extends Node2D

@onready var VICTORYSCENE = preload("res://scenes/moon_victory.tscn").instantiate()
@onready var GLOBALS = $/root/Globals

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == &"Player":
		var game_root = get_node("/root/GameScene")
		GLOBALS.LOONVIEW.hide()
		GLOBALS.PLAYER.get_node("Camera2D").top_level = true
		GLOBALS.PLAYER.get_node("Camera2D").global_position = Vector2(640, 360)
		GLOBALS.PLAYER.global_position = Vector2(0,0)
		GLOBALS.PLAYER.done = true
		game_root.hide()
		get_tree().root.add_child(VICTORYSCENE)
