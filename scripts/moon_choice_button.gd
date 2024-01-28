extends Button

var choice_index = 0
@onready var DIALOGUE = get_node("/root/MoonDialogue")

func _on_pressed():
	DIALOGUE._select_choice(choice_index)
