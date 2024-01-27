extends Node2D

@onready var _ink_player = $InkPlayer

#@export var


func _ready():
	_ink_player.connect("loaded", _story_loaded)
	_ink_player.connect("continued", _continued)
	_ink_player.connect("prompt_choices", _prompt_choices)
	_ink_player.connect("ended", _ended)

	_ink_player.create_story()


func _story_loaded(successfully: bool):
	if !successfully:
		return

	_ink_player.continue_story()


func _continued(text, tags):
	$Header.text = text
	_ink_player.continue_story()


func _prompt_choices(choices: Array):
	if !choices.is_empty():
		print(choices)

func _select_choice(choice):
	_select_choice(choice)


func _ended():
	pass

func _continue_story():
	while _ink_player.can_continue:
		var text = _ink_player.continue_story()

		# This text is a line of text from the ink story.
		# Set the text of a Label to this value to display it in your game.
		$Header.text = text

	if _ink_player.has_choices:
		# 'current_choices' contains a list of the choices, as strings.
		for choice in _ink_player.current_choices:
			print(choice)
