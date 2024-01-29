extends Node
class_name Loon

var loon_number: StringName = "Loon3"

@export var max_boredom: float = 35
@export var cooldown: float = 2.0
@export var length: float = 0.3
@onready var GLOBALS: Node = get_node("/root/Globals")

@onready var PLAYER = GLOBALS.PLAYER

var _cooldown = 0.0
var _length = 0.0
var _boredom: float = 0

var UINODE: Node
var UIBOREDOM: ProgressBar
var UICOOLDOWN: TextureProgressBar
var UIHOTKEY: Label

func _ready():
	var sounds = GLOBALS.PLAYER.get_node("loon_sounds")
	sounds.clip_stopped.connect(hide_face)
	
	var template = GLOBALS.LOONVIEW.get_node("Holder/Template")
	UINODE = template.duplicate()
	template.add_sibling(UINODE)
	UINODE.show()
	UIBOREDOM = UINODE.get_node("Portrait/Boredom")
	UIHOTKEY = UINODE.get_node("Hotkey")
	UICOOLDOWN = UIHOTKEY.get_node("Cooldown")

	UIHOTKEY.text = InputMap.action_get_events(loon_number)[0].as_text()[0]
	UIBOREDOM.value = 1
	UICOOLDOWN.value = 100


# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed(loon_number):
		if _cooldown < 0:
			var sounds = GLOBALS.PLAYER.get_node("loon_sounds")
			sounds.play_sound()
			GLOBALS.PLAYER.get_node("Graphics/" + loon_number).show()
			_boredom = 0
			_length = length
			_cooldown = cooldown
			
func hide_face():
	GLOBALS.PLAYER.get_node("Graphics/" + loon_number).hide()

func _bored():
	pass

func _active(delta):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	PLAYER.thrust_input = 0.0
	_cooldown -= delta
	_length -= delta
	_boredom += (delta * 3)
	UICOOLDOWN.value = (cooldown - _cooldown) / cooldown * 100
	UIBOREDOM.value =  (_boredom / max_boredom) * (_boredom / max_boredom) * 100
	if _length > 0:
		_active(delta)
	if _boredom > max_boredom:
		_bored()
