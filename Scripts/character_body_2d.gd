extends CharacterBody2D

var speed = 100

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
	velocity.x = horizontal_direction * speed
	velocity.y = vertical_direction * speed

	if velocity != Vector2.ZERO:
		if abs(velocity.x) > abs(velocity.y):
			last_direction = Vector2.RIGHT if velocity.x > 0 else Vector2.LEFT
			
			if horizontal_direction > 0:
				$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.flip_h = true

			$AnimatedSprite2D.play(animations.move_horizontal)
		elif abs(velocity.y) > abs(velocity.x) and velocity.y < 0:
			last_direction = Vector2.UP
			$AnimatedSprite2D.play(animations.move_up)
		else:
			last_direction = Vector2.DOWN
			$AnimatedSprite2D.play(animations.move_down)
	else:
		if last_direction == Vector2.UP:
			$AnimatedSprite2D.play(animations.idle_up)
		elif last_direction == Vector2.DOWN:
			$AnimatedSprite2D.play(animations.idle_down)
		else:
			$AnimatedSprite2D.play(animations.idle_horizontal)


	move_and_slide()
