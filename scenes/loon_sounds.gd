extends AudioStreamPlayer2D

@export var clip1start = 0.0
@export var clip1end = 0.0
@export var clip2start = 0.0
@export var clip2end = 0.0
@export var clip3start = 0.0
@export var clip3end = 0.0
var rng = RandomNumberGenerator.new()

@export var clip_playing = -1

func play_sound():
	clip_playing = rng.randi_range(1,3)
	var clip_pitch = rng.randf_range(.9, 1.1)
	pitch_scale = clip_pitch
	if clip_playing == 1:
		play(clip1start)
	if clip_playing == 2:
		play(clip2start)
	if clip_playing == 3:
		play(clip3start)

func _process(_delta):
	if clip_playing == 1 && get_playback_position() >= clip1end:
		stop()
	if clip_playing == 2 && get_playback_position() >= clip2end:
		stop()
	if clip_playing == 3 && get_playback_position() >= clip3end:
		stop()
