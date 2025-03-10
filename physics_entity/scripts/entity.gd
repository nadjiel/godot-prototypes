
class_name Entity
extends CharacterBody2D

# Stores the default GRAVITY_ACCELERATION in tiles/s²
const GRAVITY_ACCELERATION: float = 32.0

# Stores the default MAX_FALLING_SPEED in tiles/s
const MAX_FALLING_SPEED: float = 32.0

signal moved(from: Vector2, to: Vector2)

signal z_changed(new_z: float)

var input := EntityInput.new():
	set = set_input,
	get = get_input

@export_custom(PROPERTY_HINT_NONE, "suffix:tiles/s")
var speed: float = 0.0:
	set = set_speed,
	get = get_speed

@export_custom(PROPERTY_HINT_NONE, "suffix:tiles/s²")
var gravity_acceleration: float = GRAVITY_ACCELERATION:
	set = set_gravity_acceleration,
	get = get_gravity_acceleration

@export_custom(PROPERTY_HINT_NONE, "suffix:tiles/s")
var max_falling_speed: float = MAX_FALLING_SPEED:
	set = set_max_falling_speed,
	get = get_max_falling_speed

@export var z: float = 0.0:
	set = set_z,
	get = get_z

@onready var previous_position: Vector2 = global_position:
	set = set_previous_position,
	get = get_previous_position

#region Setters & Getters

func set_previous_position(new_position: Vector2) -> void:
	previous_position = new_position

func get_previous_position() -> Vector2:
	return previous_position

func set_input(new_input: EntityInput) -> void:
	input = new_input

func get_input() -> EntityInput:
	return input

func set_speed(new_speed: float) -> void:
	speed = new_speed

func get_speed() -> float:
	return speed

func set_gravity_acceleration(new_acceleration: float) -> void:
	gravity_acceleration = new_acceleration

func get_gravity_acceleration() -> float:
	return gravity_acceleration

func set_max_falling_speed(new_speed: float) -> void:
	max_falling_speed = new_speed

func get_max_falling_speed() -> float:
	return max_falling_speed

func set_z(new_z: float) -> void:
	var previous_z: float = z
	
	z = new_z
	
	if previous_z != new_z:
		z_changed.emit(new_z)

func get_z() -> float:
	return z

func get_speed_px() -> float:
	return Util.tile_to_pixel(speed)

func get_gravity_acceleration_px() -> float:
	return Util.tile_to_pixel(gravity_acceleration)

func get_max_falling_speed_px() -> float:
	return Util.tile_to_pixel(max_falling_speed)

#endregion

func warn_no_input() -> void:
	push_warning("Entity without input object")

func is_moving() -> bool:
	return previous_position != global_position

func is_midair() -> bool:
	return z < Util.GROUND_Z

func is_on_ground() -> bool:
	return not is_midair()

func _fall(delta: float) -> void:
	if input == null:
		return warn_no_input()
	
	# Incrementing z_speed by gravity_acceleration with delta
	input.z_speed += get_gravity_acceleration_px() * delta
	
	# Preventing z_speed to cross max_fall_speed
	input.z_speed = minf(input.z_speed, get_max_falling_speed_px())

func _stop_fall() -> void:
	z = Util.GROUND_Z
	
	if input == null:
		return warn_no_input()
	
	# Resetting z_speed to 0 if less than it
	input.z_speed = minf(input.z_speed, 0.0)

func _physics_process(delta: float) -> void:
	previous_position = global_position
	
	if is_midair():
		_fall(delta)
	
	# Incrementing z by z_speed with delta
	z += input.z_speed * delta
	
	if is_on_ground():
		_stop_fall()
	
	# Delta is implicit by default with velocity
	velocity = input.direction * input.speed
	
	move_and_slide()
	
	if is_moving():
		moved.emit(previous_position, global_position)
