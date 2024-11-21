extends Node2D

@export var player_scene : PackedScene
@export var ball_scene : PackedScene

var players = []
var player1
var player2
var ball

func _ready():
	player1 = player_scene.instantiate()
	player2 = player_scene.instantiate()
	
	player1.player_number = 1
	player2.player_number = 2
	
	players.append(player1)
	players.append(player2)
	
	ball = ball_scene.instantiate()
	
	add_child(player1)
	add_child(player2)
	add_child(ball)
	
	ball.connect("reset_signal", _on_ball_reset)
	
	reset_game()

func _process(delta):
	update_player_facing()

func _on_ball_reset():
	reset_game()

func update_player_facing():
	var player1_sprite = player1.get_node("AnimatedSprite2D")
	var player2_sprite = player2.get_node("AnimatedSprite2D")
	
	if player1.position.x < player2.position.x:
		player1_sprite.flip_h = false
		player2_sprite.flip_h = true
	else:
		player1_sprite.flip_h = true
		player2_sprite.flip_h = false

func reset_game():
	reset_players()

func reset_players():
	player1.reset_movement()
	player2.reset_movement()
