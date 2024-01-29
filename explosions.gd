extends Node2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for child in get_children():
		for explosion: AnimatedSprite2D in child.get_children():
			explosion.frame = rng.randi_range(0, 4)
			explosion.play()



func _explode_sound():
	if visible:
		for child in get_children():
			for explosion: AnimatedSprite2D in child.get_children():
				if explosion.frame == 0:
					var pitch = rng.randf_range(.9, 1.1)
					var expl = rng.randi_range(0, 3)
					if expl == 1:
						$explode1.pitch_scale = pitch
						$explode1.play()
					if expl == 2:
						$explode2.pitch_scale = pitch
						$explode2.play()
					if expl == 3:
						$explode3.pitch_scale = pitch
						$explode3.play()
