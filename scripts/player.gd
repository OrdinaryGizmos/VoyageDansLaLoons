class_name Player
extends AnimatableBody2D

var velocity := Vector2.ZERO
const THRUST := 250.0
const DECEL_BOOST := 20.0
const MAX_SPEED := 500.0
const TURN := 4.5

@onready var test_gravity_source:Node2D = $"../Sprite2D"
const TEST_GRAVITY := 150.0


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		velocity = Vector2.ZERO
	
	var turn_input := Input.get_axis("left", "right")
	var thrust_input := Input.get_axis("back", "forward")
	
	if not is_zero_approx(thrust_input):
		var thrust_accel := THRUST
		if velocity.dot(-global_transform.y) * thrust_input < 0.0:
			thrust_accel *= DECEL_BOOST
		
		velocity = velocity.move_toward(
				-global_transform.y * thrust_input * MAX_SPEED,
				thrust_accel * delta
			)
	
	rotate(TURN * turn_input * delta)
	
	var moon_gravity_direction := global_position.direction_to(test_gravity_source.global_position)
	velocity += moon_gravity_direction * TEST_GRAVITY * delta
	
	move_and_slide(velocity * delta)


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


# local should be a normalized vector
#func convert_to_local_gravity(local: Vector2) -> void:
#	velocity = velocity.rotated(velocity.normalized().angle_to(local))
