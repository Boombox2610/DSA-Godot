extends TileMap

var astar = AStarGrid2D.new()
var map_rect = Rect2i()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var tilemap_size = get_used_rect().end - get_used_rect().position
	map_rect = Rect2i(Vector2i.ZERO, tilemap_size)
	
	
	astar.region = map_rect
	print("map_rect astar region: ", astar.region)
	var tile_size = get_tileset().tile_size
	astar.cell_size = tile_size
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_EUCLIDEAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_EUCLIDEAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coords = Vector2i(i,j)
			
			var tile_data = get_cell_tile_data(0, coords)
			if not tile_data or tile_data.get_custom_data('Col') == 'yes':
				astar.set_point_solid(coords)
				
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_point_walkable(position):
	var map_position = local_to_map(position)
	if map_rect.has_point(map_position) and not astar.is_point_solid(map_position):
		return true
	return false
	
