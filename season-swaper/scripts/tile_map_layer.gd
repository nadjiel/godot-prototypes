# Allows easily swapping different textures for this tile map.
class_name SkinSwapperTileMapLayer
extends TileMapLayer

# Id of tile set source that should have its texture updated.
@export var swapper_source_id: int = -1

# Array with a texture for each season.
@export var skins_textures: Array[Texture2D]

# Tells if has skin in skins textures array.
func has_skin(skin_id: int) -> bool:
	return skin_id >= 0 and skin_id < skins_textures.size()

# Swaps skin to the one with the id passed, if any.
func swap_skin(skin_id: int) -> void:
	if not has_skin(skin_id):
		return
	if tile_set == null:
		return
	
	if not tile_set.has_source(swapper_source_id):
		return
	
	var source: TileSetSource = tile_set.get_source(swapper_source_id)
	
	if source is not TileSetAtlasSource:
		return
	
	source = source as TileSetAtlasSource
	
	source.texture = skins_textures[skin_id]
