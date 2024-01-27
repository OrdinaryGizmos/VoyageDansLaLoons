class_name Player
extends AnimatableBody2D

# controls
var thrust_input := 0.0
var turn_input := 0.0

var velocity := Vector2.ZERO

# constants
const THRUST := 250.0
const DECEL_BOOST := 2.0
const MAX_SPEED := 500.0
const TURN := 4.5
const MOON_FADE_DIST_MIN := 600.0

@onready var moon:Node2D = get_parent().find_child("Moon")

# indicator
@onready var indicator:Node2D = $Indicator


func _ready() -> void:
	indicator.top_level = true


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		velocity = Vector2.ZERO
	
	if not is_zero_approx(thrust_input):
		var thrust_accel := THRUST
		if velocity.dot(-global_transform.y) * thrust_input < 0.0:
			thrust_accel *= DECEL_BOOST
		
		velocity = velocity.move_toward(
				-global_transform.y * thrust_input * MAX_SPEED,
				thrust_accel * delta
			)
	
	rotate(TURN * turn_input * delta)
	
	move_and_slide(velocity * delta)
	
	# the indicator needs to be top level so it can rotate independent of the
	# player, so the position manually needs to be set as well
	indicator.global_position = global_position
	indicator.modulate.a = 1.0 if global_position.distance_to(moon.global_position) >= MOON_FADE_DIST_MIN else 0.0
	indicator.rotation = deg_to_rad(90.0) + global_position.direction_to(moon.global_position).angle()


func move_and_slide(motion: Vector2, modify_velocity := true) -> void:
	var slides := 0
	while motion.length_squared() > 0.0 and slides < 32:
		var collision := move_and_collide(motion, true)
		if collision:
			position += collision.get_travel()
			motion = collision.get_remainder().slide(collision.get_normal())
			
			if modify_velocity:
				velocity = velocity.slide(collision.get_normal())
			
			slides += 1
		else:
			global_position += motion
			break
