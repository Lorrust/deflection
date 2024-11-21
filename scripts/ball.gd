extends CharacterBody2D

const INITIAL_SPEED = 50
const MAX_SPEED = 1500
const SPEED_GROW = 25
var speed
var INITIAL_ROTATION = 0.1
var rotation_speed = 0.1

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
		var direction = (current_target.global_position - global_position).normalized()
		velocity = direction * speed
		# Speed limit
		if velocity.length() > MAX_SPEED:
			velocity = velocity.normalized() * MAX_SPEED
			
		move_and_slide()
		update_rotation(delta)
		
func update_rotation(delta):
	rotation += rotation_speed

func change_target():
	# Change target
	if current_target == players[0]:
		current_target = players[1]
	else:
		current_target = players[0]
	
	# Increase speed, but make sure it doesn't exceed MAX_SPEED
	speed = min(speed + SPEED_GROW, MAX_SPEED)
	rotation_speed += 0.01

# TODO finish this part and create reset_ball function
func _on_area_2d_body_entered(body):
	print("touch!")
	print(body.name)
	if current_target == body:
		$Damage.play()
		reset_ball()
	else:
		pass

func reset_ball():
	position = Vector2(576, 324)
	speed = INITIAL_SPEED
	rotation_speed = INITIAL_ROTATION
