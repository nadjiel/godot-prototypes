
extends Node2D

# Updates Entity sprite's y according to its z coordinate
func _on_entity_z_changed(new_z: float) -> void:
	position.y = new_z
