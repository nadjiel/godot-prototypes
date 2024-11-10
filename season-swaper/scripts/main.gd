extends Node2D

@onready var season_manager: SeasonManager = $SeasonManager

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pass"):
		season_manager.next_season()
