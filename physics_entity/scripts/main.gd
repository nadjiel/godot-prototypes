
extends Node

# Getting slime character
@onready var slime: Slime = $Slime

# Getting ui nodes
@onready var ui_speed: Label = %Speed/Value
@onready var ui_z_speed: Label = %ZSpeed/Value
@onready var ui_direction: Label = %Direction/Value
@onready var ui_facing_direction: Label = %FacingDirection/Value
@onready var ui_peak_speed: Label = %PeakSpeed/Value
@onready var ui_peak: Label = %Peak/Value

# Variables used to monitor slime
@onready var previous_z_speed: float = absf(slime.input.z_speed)
@onready var previous_z: float = slime.z

func _process(_delta: float) -> void:
	# Update UI info
	ui_speed.text = "%.1f" % slime.input.speed
	ui_z_speed.text = "%.1f" % slime.input.z_speed
	ui_direction.text = str(slime.input.direction)
	ui_facing_direction.text = str(slime.input.facing_direction)
	
	# Update slime's peak_z_speed UI info
	if absf(slime.input.z_speed) > previous_z_speed:
		ui_peak_speed.text = "%.1f" % absf(slime.input.z_speed)
		
		previous_z_speed = absf(slime.input.z_speed)
	# Update slime's peak_z_speed UI info back to 0
	if slime.input.z_speed == 0.0:
		ui_peak_speed.text = "0"
		previous_z_speed = 0.0
	
	# Update slime's peak_z UI info
	if slime.z < previous_z:
		ui_peak.text = "%.1f" % slime.z
		
		previous_z = slime.z
	# Update slime's peak_z UI info back to 0
	if slime.z == 0.0:
		ui_peak.text = "0"
		previous_z = 0.0

func _unhandled_input(event: InputEvent) -> void:
	# Rocket jump to test jump easing appearence
	if event.is_action_pressed("debug1"):
		slime.jump(128.0)
