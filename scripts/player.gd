class_name Player
extends AnimatableBody2D

# controls
var thrust_input := 0.0
var turn_input := 0.0

var velocity := Vector2.ZERO

# constants
const THRUST := 250.0
const DECEL_BOOST := 2.0
const BOUNCE_SPEED_ABSORB := 1.0 # 0.6
const MAX_SPEED := 500.0
const TURN := 4.5
const MOON_FADE_DIST_MIN := 600.0

const PX_TO_RLU_SCALE_FACTOR := 0.0333
const UNIT := "meters"

@onready var moon:Node2D = get_parent().find_child("Moon")
@onready var MOON_RADIUS:float = moon.get_node("StaticBody2D/CollisionShape2D").shape.radius * moon.scale.x

# indicator
@onready var indicator:Node2D = $Indicator
@onready var arrow:Node2D = $Indicator/Arrow
@onready var distance_text:Label = $Indicator/Arrow/Label


func _ready() -> void:
	indicator.top_level = true
	distance_text.top_level = true


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug") and OS.has_feature("debug"):
		velocity = Vector2.ZERO
	
	if not is_zero_approx(thrust_input):
		$Graphics/Boost.show()
		$Graphics/Drift.hide()
		var thrust_accel := THRUST
		if velocity.dot(-global_transform.y) * thrust_input < 0.0:
			thrust_accel *= DECEL_BOOST
		
		velocity = velocity.move_toward(
				-global_transform.y * thrust_input * MAX_SPEED,
				thrust_accel * delta
			)
	else:
		$Graphics/Boost.hide()
		$Graphics/Drift.show()
		
	rotate(TURN * turn_input * delta)
	
	move(velocity * delta)
	
	# the indicator needs to be top level so it can rotate independent of the
	# player, so the position manually needs to be set as well
	indicator.global_position = global_position
	distance_text.global_position = arrow.global_position
	distance_text.text = "%s %s" % [str(snappedf(maxf(global_position.distance_to(moon.global_position) - MOON_RADIUS, 0.0) * PX_TO_RLU_SCALE_FACTOR, 1.00)), UNIT]
	indicator.rotation = deg_to_rad(90.0) + global_position.direction_to(moon.global_position).angle()


func move(motion: Vector2) -> void:
	var collision := move_and_collide(motion, true)
	if collision:
		position += collision.get_travel()
		velocity = velocity.bounce(collision.get_normal()) * BOUNCE_SPEED_ABSORB
	else:
		global_position += motion
