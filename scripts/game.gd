extends Node2D

@export var player_scene : PackedScene
@export var ball_scene : PackedScene
@export var scoreboard_scene: PackedScene

var players = []
var player1
var player2
var ball

var score_player1 = 0
var score_player2 = 0

var score_label_player1
var score_label_player2

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
	
	score_label_player1 = scoreboard_scene.instantiate()
	score_label_player2 = scoreboard_scene.instantiate()
	
	score_label_player1.text = "Player 1: " + str(score_player1)
	score_label_player2.text = "Player 2: " + str(score_player2)
	
	add_child(score_label_player1)
	add_child(score_label_player2)
	
	score_label_player1.position = Vector2(180, 30)
	score_label_player2.position = Vector2(824, 30)
	
	ball.connect("reset_signal", _on_ball_reset)
	
	reset_game()

func _process(delta):
	update_player_facing()

func _on_ball_reset(body):
	reset_game()
	update_score(body)

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

func update_score(player: Object):
	if player.player_number == 1:
		score_player2 += 1
	elif player.player_number == 2:
		score_player1 += 1
	
	score_label_player1.text = "Player 1: " + str(score_player1)
	score_label_player2.text = "Player 2: " + str(score_player2 - 1)

func _on_button_pressed() -> void:
	get_tree().quit()
