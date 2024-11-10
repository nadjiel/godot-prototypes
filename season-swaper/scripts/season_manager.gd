# Handles the seasons.
class_name SeasonManager
extends Node

# Emitted on season change.
signal season_changed(new_season)

# Maximum number of seasons.
const TOTAL_SEASONS: int = 4

# The current season id.
var current_season: int = 0:
	set = set_current_season

func set_current_season(new_season: int) -> void:
	new_season = new_season % TOTAL_SEASONS
	
	var old_season: int = current_season
	
	current_season = new_season
	
	if old_season != new_season:
		season_changed.emit(new_season)

# Goes to next season.
func next_season() -> void:
	current_season += 1
