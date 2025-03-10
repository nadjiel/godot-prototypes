
class_name Slime
extends Entity

@export_custom(PROPERTY_HINT_NONE, "suffix:tiles")
var jump_height: float = 1.0:
	set = set_jump_height,
	get = get_jump_height

@onready var sprite_container: Node2D = $SpriteContainer
@onready var animator: AnimationPlayer = $Animator

func set_jump_height(new_height: float) -> void:
	jump_height = new_height

func get_jump_height() -> float:
	return jump_height

func get_jump_height_px() -> float:
	return Util.tile_to_pixel(jump_height)

func _ready() -> void:
	# Watch for facing_direction changes, for sprite mirroring
	input.facing_direction_changed.connect(_on_input_facing_direction_changed)

func _unhandled_input(event: InputEvent) -> void:
	if input == null:
		return
	
	# Sets the input direction
	input.direction = Input.get_vector("left", "right", "up", "down")
	# Updates the facing_direction if the direction is inputed
	if not input.direction.is_zero_approx():
		input.facing_direction = Util.snap_vector_to_angle(input.direction, PI)
	# Updates the z_speed through the jump method if a jump was inputed
	if event.is_action_pressed("jump"):
		jump(get_jump_height_px())

func _process(_delta: float) -> void:
	# Updates the input speed
	input.speed = get_speed_px() if not input.direction.is_zero_approx() else 0.0
	
	# Animate
	if is_on_ground():
		if is_moving():
			animator.play(&"slime/move")
		else:
			animator.play(&"slime/idle")
	else:
		animator.play(&"slime/jump")

# Makes the slime jump a certain height using the get_initial_speed formula
func jump(height: float) -> void:
	input.z_speed = -Util.get_initial_speed(get_gravity_acceleration_px(), height)

# Inverts the x scale of the sprite to match the facing_direction
func _on_input_facing_direction_changed(new_direction: Vector2) -> void:
	sprite_container.scale.x = new_direction.x
