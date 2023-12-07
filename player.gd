extends CharacterBody2D

@export var laserScene: PackedScene

var speed = 400
var angular_speed = PI
var laser

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "run"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = 0
	if Input.is_action_pressed("left"):
		direction = -1
	if Input.is_action_pressed("right"):
		direction = 1

	rotation += angular_speed * direction * delta

	velocity = Vector2.ZERO
	if Input.is_action_pressed("forward"):
		velocity = Vector2.UP.rotated(rotation) * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	move_and_slide()
	
	if Input.is_action_just_pressed("fire"):
		laser = laserScene.instantiate()
	if Input.is_action_just_released("fire"):
		laser.stop_laser()
