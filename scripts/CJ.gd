extends Loon

var start_bored: bool

func _ready():
	super()
	max_boredom = 35

func _bored():
	super()
	_cooldown = cooldown
	if !start_bored:
		_length = 10

	if _length < 0:
		_boredom = 0

	start_bored = true

func _active(delta):
	super(delta)
	PLAYER.turn_input = 1.0 * (_length / length)
