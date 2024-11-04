extends CharacterBody2D

@onready var tilemap: TileMap = $"../TileMap"
@onready var path_debug: Line2D = $"../Line2D"
@onready var target_player: CharacterBody2D = $"../Enemy"  # Reference to the main player node
var current_path: Array[Vector2i] = []
var speed: float = 80.0  # Movement speed for the enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set up path debugging, if needed
	if !has_node("PathDebug"):
		path_debug.width = 4.0
		path_debug.default_color = Color(1, 0, 1, 0.5)  # Semi-transparent purple for enemy path

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If the player is assigned and exists, follow them
	if target_player:
		update_path_to_player()

	# Follow the current path to the player
	if !current_path.is_empty():
		var target_position = tilemap.map_to_local(current_path.front())
		global_position = global_position.move_toward(target_position, speed * delta)
		
		if global_position.distance_to(target_position) < 1:
			current_path.pop_front()
			if current_path.is_empty():
				path_debug.clear_points()

func update_path_to_player() -> void:
	# Get player's position in map coordinates
	var player_map_position = tilemap.local_to_map(target_player.global_position)
	var enemy_map_position = tilemap.local_to_map(global_position)
	
	# Calculate path to player and store it in current_path
	current_path = tilemap.astar.get_id_path(enemy_map_position, player_map_position).slice(1)
	update_debug_path()

func update_debug_path() -> void:
	var points: PackedVector2Array = []
	points.append(path_debug.to_local(global_position))
	
	# Convert all path points to world coordinates
	for point in current_path:
		var world_pos = tilemap.map_to_local(point)
		points.append(path_debug.to_local(world_pos))
	
	# Update the line for path visualization
	path_debug.points = points
