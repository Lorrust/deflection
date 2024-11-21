extends CharacterBody2D

var player_number
var speed = 150
var input_dir = Vector2.ZERO
var is_deflecting = false

func _physics_process(delta):
	player_movement()

	if is_deflect_button_pressed():
		$Deflect.play()
		var overlapping_areas = $DeflectArea.get_overlapping_areas()
		for area in overlapping_areas:
			if area.get_parent().name == "Ball":
				deflect_ball(area.get_parent())
				$Hit.play()

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
	
	if is_deflecting:
		$AnimatedSprite2D.play("deflect")
	else:
		if velocity != Vector2.ZERO:
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("idle")

func is_deflect_button_pressed():
	if player_number == 1:
		return Input.is_action_just_pressed("player1_deflect")
	elif player_number == 2:
		return Input.is_action_just_pressed("player2_deflect")
	return false

func deflect_ball(ball):
	is_deflecting = true
	$Cooldown.start()
	$AnimatedSprite2D.play("deflect")
	if ball.current_target == self:
		ball.change_target()
		print("deflected!")


func _on_cooldown_timeout() -> void:
	is_deflecting = false
