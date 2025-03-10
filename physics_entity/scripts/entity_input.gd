# NOTE: Everything is set in pixels in this class
class_name EntityInput
extends RefCounted

signal facing_direction_changed(new_direction: Vector2)

var speed: float = 0.0:
	set = set_speed,
	get = get_speed

var z_speed: float = 0.0:
	set = set_z_speed,
	get = get_z_speed

var direction: Vector2 = Vector2.ZERO:
	set = set_direction,
	get = get_direction

var facing_direction: Vector2 = Vector2.ZERO:
	set = set_facing_direction,
	get = get_facing_direction

func set_speed(new_speed: float) -> void:
	speed = new_speed

func get_speed() -> float:
	return speed

func set_z_speed(new_speed: float) -> void:
	z_speed = new_speed

func get_z_speed() -> float:
	return z_speed

func set_direction(new_direction: Vector2) -> void:
	# Preventing normalization of vectors zero
	if new_direction.is_equal_approx(Vector2.ZERO):
		direction = new_direction
		return
	
	direction = new_direction.normalized()

func get_direction() -> Vector2:
	return direction

func set_facing_direction(new_direction: Vector2) -> void:
	var old_direction: Vector2 = facing_direction
	
	facing_direction = new_direction
	
	if not old_direction.is_equal_approx(new_direction):
		facing_direction_changed.emit(new_direction)

func get_facing_direction() -> Vector2:
	return facing_direction

func copy_to(input_object: EntityInput, input_name: StringName) -> void:
	input_object.set(input_name, get(input_name))

func _to_string() -> String:
	return "{SPD:%.2f; ZSPD:%.2f; DIR:%.2v; FACE:%s}" % [
		speed, z_speed, direction, facing_direction
	]
