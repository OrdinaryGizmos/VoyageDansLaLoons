extends Node2D

@onready var _ink_player = $InkPlayer

@onready var LAUNCHSCENE = preload("res://scenes/jonny_debug.tscn").instantiate()
@onready var GLOBALS: Node = get_node("/root/Globals")


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
	$Header.text += "\n" + text
	#_ink_player.continue_story()


func _prompt_choices(choices: Array):
	if !choices.is_empty():
		for choice in choices:
			if choice is String:
				$Header.text += choice

func _select_choice(choice):
	_ink_player.choose_choice_index(choice)
	_ink_player.continue_story()


func _proceed():
	if _ink_player.has_choices:
		_select_choice(0)
	else:
		_ink_player.continue_story()

func _ended():
	$Proceed.hide()


func _on_launch_button_pressed():
	var crew_root = get_node("/root/CrewSelect")
	crew_root.hide()
	get_tree().root.add_child(LAUNCHSCENE)
	GLOBALS.PLAYER = LAUNCHSCENE.find_child("Player")
	var loon_number = 0
	for loon in GLOBALS.LOONS:
		loon_number += 1
		var loon_script = load("res://scripts/" + loon + ".gd")
		var loon_node = Node.new()
		loon_node.set_script(loon_script)
		loon_node.loon_number = "Loon" + str(loon_number)
		GLOBALS.PLAYER.add_child(loon_node)

