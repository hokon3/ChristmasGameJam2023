extends RayCast2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var endpoint = target_position
	force_raycast_update()
	if (is_colliding()):
		endpoint = get_collision_point()
	$Line2D.add_point(endpoint, 1)
	
func stop_laser():
	queue_free()
