extends CharacterBody2D

@export var player_number = 1
@export var speed = 150

var input_dir = Vector2.ZERO

func _physics_process(delta):
	player_movement()


func get_input():
	if player_number == 1:
		input_dir.x = int(Input.is_action_pressed("player1_right")) - int(Input.is_action_pressed("player1_left"))
		input_dir.y = int(Input.is_action_pressed("player1_down")) - int(Input.is_action_pressed("player1_up"))
	elif player_number == 2:
		input_dir.x = int(Input.is_action_pressed("player2_right")) - int(Input.is_action_pressed("player2_left"))
		input_dir.y = int(Input.is_action_pressed("player2_down")) - int(Input.is_action_pressed("player2_up"))

	return input_dir.normalized()


func player_movement():
	input_dir = get_input()


	velocity = input_dir * speed
	move_and_slide()

func _on_deflect_area_area_entered(area):
	print(area.get_parent().name)
	if area.get_parent().name == "Ball":
		deflect_ball(area.get_parent())

func deflect_ball(ball):
	#if ball.current_target == self:
	ball.change_target()
	print("deflected!")
