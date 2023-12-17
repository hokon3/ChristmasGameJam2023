extends RayCast2D

var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var endpoint = target_position
	force_raycast_update()
	if (is_colliding()):
		endpoint = to_local(get_collision_point())
		if ($Line2D.width > 0 && get_collider().has_method("hit")):
			get_collider().call_deferred("hit", damage)
	$Line2D.points[1] = endpoint
	if Input.is_action_just_pressed("fire"):
		$Line2D.width = damage
	if Input.is_action_just_released("fire"):
		$Line2D.width = 0
		
func power_up():
	damage = damage * 2
	if damage == 2:
		$Line2D.default_color.g = 1
	if damage == 4:
		$Line2D.default_color.r = 0
		$Line2D.default_color.b = 1
	if damage == 8:
		$Line2D.default_color.r = 0
		$Line2D.default_color.g = 0
		$Line2D.default_color.b = 1
	if damage == 16:
		$Line2D.default_color.r = 0
		$Line2D.default_color.g = 1
		$Line2D.default_color.b = 0

