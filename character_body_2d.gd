extends CharacterBody2D

const SPEED = 200

func _ready():
	# Add visual representation
	var rectangle = ColorRect.new()
	rectangle.size = Vector2(20, 20)
	rectangle.position = -rectangle.size / 2  # Center the rectangle
	rectangle.color = Color(1, 0, 0)  # Red
	add_child(rectangle)
	
	# Set initial position	position = Vector2(48, 48)  # This puts the player in the first road tile

func _physics_process(_delta):
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if direction.length() > 0:
		direction = direction.normalized()
		
	velocity = direction * SPEED
	move_and_slide()
