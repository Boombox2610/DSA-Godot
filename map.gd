extends Node2D

@onready var tilemap = $TileMap

func _ready():
	create_maze()

func create_maze():
	# Create a new TileMap node if not already added in editor
	if not tilemap:
		tilemap = TileMap.new()
		add_child(tilemap)
	
	# Set up the TileMap properties
	tilemap.cell_quadrant_size = 16
	
	# Define the maze layout (0 = road, 1 = wall)
	var maze_layout = [
		[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
		[1,0,0,0,0,0,1,0,0,0,0,0,0,0,1],
		[1,0,1,1,1,0,1,0,1,1,1,1,1,0,1],
		[1,0,0,0,1,0,0,0,0,0,0,0,1,0,1],
		[1,1,1,0,1,1,1,1,1,1,1,0,1,0,1],
		[1,0,0,0,0,0,1,0,0,0,0,0,0,0,1],
		[1,0,1,1,1,0,1,0,1,1,1,1,1,0,1],
		[1,0,0,0,1,0,0,0,1,0,0,0,0,0,1],
		[1,1,1,0,1,1,1,1,1,0,1,1,1,0,1],
		[1,0,0,0,0,0,0,0,0,0,1,0,0,0,1],
		[1,0,1,1,1,1,1,1,1,1,1,0,1,1,1],
		[1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
		[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
	]
	
	# Place tiles according to the layout
	for y in range(maze_layout.size()):
		for x in range(maze_layout[y].size()):
			if maze_layout[y][x] == 1:  # Wall
				tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(1, 0))
			else:  # Road
				tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0))
