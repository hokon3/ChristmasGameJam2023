extends CharacterBody2D

signal dead
signal healthChange

var speed = 400
var angular_speed = PI
var health = 3
var alive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "run"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (alive):
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
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if (collision.get_collider().name == "santa"):
				collision.get_collider().break_shield()
		
func revive():
	alive = true
	
func snowballed():
	$SnowballHitSound.play()
	health -= 1
	healthChange.emit(health)
	if health <= 0:
		visible = false
		$CollisionShape2D.disabled = true
		dead.emit()
		alive = false
		
func pick_up_powerup():
	$Laser.power_up()
