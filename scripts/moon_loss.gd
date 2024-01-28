extends Node2D

@export var start_story: bool = false
@onready var _ink_player = $InkPlayer

@onready var moon_text_box: RichTextLabel = get_node("Control/HSplitContainer/MarginContainer/VSplitContainer/MoonSpeech")
@onready var choice_holder = get_node("Control/HSplitContainer/MarginContainer/VSplitContainer/Choices")
@onready var continue_button = get_node("Control/HSplitContainer/MarginContainer/VSplitContainer/Choices/ChoiceButton")
@onready var moon_face = get_node("Control/Moon2")
var moon_text: String = ""
var speed = 2

func _ready():
	_ink_player.connect("loaded", _story_loaded)
	_ink_player.connect("continued", _continued)
	_ink_player.connect("prompt_choices", _prompt_choices)
	_ink_player.connect("ended", _ended)
	_ink_player.create_story()

func _process(delta):
	if !start_story:
		continue_button.hide()
		return

	if moon_text_box.visible_ratio < 1:
		continue_button.hide()
	else:
		continue_button.show()


func _story_loaded(successfully: bool):
	if !successfully:
		return
	moon_text_box.visible_ratio = 0
	_ink_player.continue_story()


func _continued(text, _tags):
	moon_text_box.visible_ratio = 0
	moon_text_box.text = text

func _prompt_choices(choices: Array):
	print("getting choices")
	if !choices.is_empty():
		for choice in choices:
			var new_choice = continue_button.duplicate()
			new_choice.choice_index = choice.choice_index
			new_choice.show()
			choice_holder.add_child(new_choice)

func _select_choice(choice):
	moon_text_box.visible_ratio = 0
	moon_text_box.text = ""
	# for child in choice_holder.get_children():
	# 	child.hide()
	_ink_player.choose_choice_index(choice)
	moon_text_box.text = _ink_player.continue_story()


func _proceed():
	_ink_player.continue_story()

func _ended():
	$AnimationPlayer.play("explode")
	continue_button.hide()

func _change_scene():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_moon_speak_timeout():
	if moon_text_box.visible_ratio < 1 && start_story:
		moon_face.visible = !moon_face.visible
		moon_text_box.visible_characters += 1 * speed
	else:
		moon_face.visible = false
