extends CharacterBody2D

var walk_speed = 100
var run_speed = 200

var isRunning = false

const animations = {
	"idle_down": "idle_down",
	"idle_up": "idle_up",
	"idle_horizontal": "idle_horizontal",
	"move_down": "move_down",
	"move_up": "move_up",
	"move_horizontal": "move_horizontal",
	"attack_down": "attack_down",
	"attack_up": "attack_up",
	"attack_horizontal": "attack_horizontal",
	"death": "death"
}

var last_direction := Vector2.DOWN

func _ready() -> void:
	$AnimatedSprite2D.play(animations.idle_down)
	pass

func _physics_process(delta: float) -> void:
	var horizontal_direction = Input.get_axis("left", "right")
	var vertical_direction = Input.get_axis("up", "down")
	var direction = Vector2(horizontal_direction, vertical_direction)

	isRunning = Input.is_action_pressed("run")

	if direction != Vector2.ZERO:
		direction = direction.normalized()

	var currentSpeed = run_speed if isRunning else walk_speed

	velocity = direction * currentSpeed

	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			last_direction = Vector2.RIGHT if direction.x > 0 else Vector2.LEFT
			$AnimatedSprite2D.flip_h = direction.x < 0
			$AnimatedSprite2D.play(animations.move_horizontal)
		elif abs(direction.y) > abs(direction.x):
			if direction.y < 0:
				last_direction = Vector2.UP
				$AnimatedSprite2D.play(animations.move_up)
			else:
				last_direction = Vector2.DOWN
				$AnimatedSprite2D.play(animations.move_down)
		else:
			last_direction = Vector2.RIGHT if direction.x > 0 else Vector2.LEFT
			$AnimatedSprite2D.flip_h = direction.x < 0
			$AnimatedSprite2D.play(animations.move_horizontal)
	else:
		if last_direction == Vector2.UP:
			$AnimatedSprite2D.play(animations.idle_up)
		elif last_direction == Vector2.DOWN:
			$AnimatedSprite2D.play(animations.idle_down)
		else:
			$AnimatedSprite2D.play(animations.idle_horizontal)

	move_and_slide()

	if Input.is_action_just_pressed("attack"):
		if last_direction == Vector2.UP:
			$AnimatedSprite2D.play(animations.attack_up)
		elif last_direction == Vector2.DOWN:
			$AnimatedSprite2D.play(animations.attack_down)
		else:
			$AnimatedSprite2D.play(animations.attack_horizontal)
