
class_name Util
extends Node

const GROUND_Z: float = 0.0

const TILE_SIZE: int = 16

# Converts a measure in tiles to a measure in pixels
static func tile_to_pixel(measure: float) -> float:
	return measure * TILE_SIZE

# Converts a measure in pixels to a measure in tiles
static func pixel_to_tile(measure: float) -> float:
	return measure / TILE_SIZE

# Snaps a vector to the closest vector that has its angle multiple of the passed angle
static func snap_vector_to_angle(vector: Vector2, angle: float) -> Vector2:
	var vector_length: float = vector.length()
	
	if angle == 0.0:
		return Vector2.RIGHT * vector_length
	
	var vector_angle: float = vector.angle()
	
	var snappable_angles_amount: int = roundi(vector_angle / angle)
	var result_vector_angle: float = snappable_angles_amount * angle
	var result: Vector2 = Vector2.from_angle(result_vector_angle)
	
	result *= vector_length
	
	return result

# Uses the kinematic function to get the initial speed of a movement with constant
# acceleration and variable displacement.
# Can be used to get the jump speed needed to reach a given height, with the
# constant acceleration being the gravity.
static func get_initial_speed(acceleration: float, displacement: float) -> float:
	return sqrt(2 * acceleration * displacement)
