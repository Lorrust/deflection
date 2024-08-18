extends CharacterBody2D

const INITIAL_SPEED = 50
const MAX_SPEED = 1500
const SPEED_GROW = 25
var speed

var players
var current_target

var screen_size = get_viewport_rect().size

func _ready():
	speed = INITIAL_SPEED
	players = get_parent().players
	if players:
		current_target = players.front()

func _process(delta):
	print(speed)
	if players and current_target:
		# Calculate the direction vector towards the target player
		var direction = (current_target.global_position - global_position).normalized()
		# Calculate the velocity towards the target player
		velocity = direction * speed
		# Apply speed limit
		if velocity.length() > MAX_SPEED:
			velocity = velocity.normalized() * MAX_SPEED
		# Move the ball
		move_and_slide()

func change_target():
	# Change target to the other player
	if current_target == players[0]:
		current_target = players[1]
	else:
		current_target = players[0]
	
	# Increase speed, but make sure it doesn't exceed MAX_SPEED
	speed = min(speed + SPEED_GROW, MAX_SPEED)

# TODO finish this part and create reset_ball function
func _on_area_2d_body_entered(body):
	print("touch!")
	print(body.name)
	if current_target == body:
		print("target touch")
		reset_ball()
	else:
		pass

func reset_ball():
	speed = INITIAL_SPEED
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
