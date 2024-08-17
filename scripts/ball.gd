extends CharacterBody2D

@export var speed = 30

#var rng = RandomNumberGenerator.new()
#
var current_target;

#func _ready():
	#current_target = get_players_in_range().front()
	##current_target = players[[rng.randi_range(0, players.size() - ]
	##update_direction()
	

func _process(delta):
	var players = get_players_in_range()
	print(players)
	if players:
		current_target = players.front()
		# Calculate the direction vector towards the target player
		var direction = (current_target.position - global_position).normalized()
		# Move the ball in the direction of the player
		velocity = direction * speed
	move_and_slide()

func get_players_in_range():
	var players_in_range = $Area2D.get_overlapping_bodies()
	if players_in_range.size() > 0:
		return players_in_range
	return null  # Return null if no players are in range

#func change_target():
	#if current_target == player1:
		#current_target = player2
	#else:
		#current_target = player1
	#update_direction()


#func update_direction():
	## Update the ball's direction to chase the new target player
	#var direction = (current_target.global_position - global_position).normalized()
	#velocity = direction * speed
