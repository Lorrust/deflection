extends CharacterBody2D

var speed = 100
const MAX_SPEED = 1000

#var rng = RandomNumberGenerator.new()
#
var current_target;

var players

func _ready():
	players = get_parent().players
	print(players)
	current_target = players.front()
	##current_target = players[[rng.randi_range(0, players.size() - ]
	#update_direction()
	

func _process(delta):
	if players:
		# Calculate the direction vector towards the target player
		var direction = (current_target.position - global_position).normalized()
		# Move the ball in the direction of the player
		velocity = direction * speed
		velocity.limit_length(MAX_SPEED)
	move_and_slide()

#func get_players_in_range():
	#var players_in_range = $Area2D.get_overlapping_bodies()
	#if players.size() > 0:
		#return players_in_range
	#return null  # Return null if no players are in range

func change_target():
	print(current_target)
	if current_target == players[0]:
		current_target = players[1]
	else:
		current_target = players[0]
	speed += 50
	#update_direction()


#func update_direction():
	# Update the ball's direction to chase the new target player
	#var direction = (current_target.position - global_position).normalized()
	#velocity = direction * speed
