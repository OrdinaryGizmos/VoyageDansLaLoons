extends Node2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for child in get_children():
		for explosion: AnimatedSprite2D in child.get_children():
			explosion.frame = rng.randi_range(0, 4)
			explosion.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
