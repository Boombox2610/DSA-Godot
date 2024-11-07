extends CharacterBody2D

@onready var tilemap: TileMap = $"../TileMap"
@onready var path_debug: Line2D = $"../Line2D"
var current_path: Array[Vector2i] = []
var start_position: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create Line2D node if it doesn't exist
	if !has_node("PathDebug"):
		path_debug.width = 4.0
		path_debug.default_color = Color(1, 0, 0, 0.5)  # Semi-transparent red
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_path.is_empty():
		return
	var target_position = tilemap.map_to_local(current_path.front())
	global_position = global_position.move_toward(target_position, 5)
	
	if global_position == target_position:
		current_path.pop_front()
		if current_path.is_empty():
			path_debug.clear_points()
	
	pass

func _unhandled_input(event: InputEvent) -> void:
	var click_position = get_global_mouse_position()
	if event.is_action_pressed("move_to"):
		if tilemap.is_point_walkable(click_position):
			start_position = global_position
			current_path = tilemap.astar.get_id_path(
				tilemap.local_to_map(global_position),
				tilemap.local_to_map(click_position)
			)
			print("To location: ", tilemap.local_to_map(click_position))
			print("Path: ",current_path)
			update_debug_path()

func update_debug_path() -> void:
	var points: PackedVector2Array = []
	points.append(path_debug.to_local(start_position))
	
	# Convert all path points to world coordinates
	for point in current_path:
		var world_pos = tilemap.map_to_local(point)
		points.append(path_debug.to_local(world_pos))
	
	# Update the line
	path_debug.points = points
